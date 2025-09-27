extends Node2D

# The amount of damage this object will deal.
@export var damage: int = 50

# This function is automatically called when a body enters the Area2D.
# It is connected via the "body_entered" signal in the editor.
func _on_body_entered(body):
	# Check if the body is the player.
	if body.name == "Player":
		# Do something specific for the player reaching the end point.
		print("Congrats! You finished the game!")
		
		# Now, handle the original damage logic if the body has a Health component.
		# The 'body' argument is the node that entered the area.
		var health_component: Health = body.get_node_or_null("Health")
		
		if health_component != null:
			# If the node has a Health component, call its take_damage function.
			health_component.take_damage(damage)
