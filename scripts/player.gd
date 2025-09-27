
extends CharacterBody2D

const SPEED = 280.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

# Get a reference to the Health component node.
@onready var health_component: Health = $Health

# Get a reference to the UI element (e.g., a ProgressBar).
#
# IMPORTANT: Right-click your health bar node in the Scene tree and
# select "Copy Node Path" to get the correct path.
# Replace the placeholder text below with that path.
@onready var health_bar: ProgressBar = get_node("../CanvasLayer/ProgressBar")

func _ready():
	# Connect the health_component's signals to our player script's functions.
	health_component.health_changed.connect(on_health_changed)
	health_component.died.connect(on_died)
	
	# Initial UI update.
	if health_bar != null:
		health_bar.max_value = health_component.max_health
		health_bar.value = health_component.current_health
	
	print("Player initialized with health: ", health_component.current_health)

# This function is called by the health_changed signal.
func on_health_changed(new_health: int, old_health: int, max_health: int):
	# Update the UI.
	if health_bar != null:
		health_bar.value = new_health
		print("Player health changed from ", old_health, " to ", new_health)
	
	# You can add other effects here, like a hurt animation or sound.

# This function is called by the died signal.
func on_died():
	print("Player has died!")
	# Stop player movement, play death animation, respawn, etc.
	set_process(false)
	$Sprite2D.visible = false
	# Call a game over screen or restart level
