# Filename: Health.gd
# This script is a reusable health component.
# Attach it as a child node to your character.

class_name Health extends Node

# A signal is a way for a node to broadcast a message.
signal health_changed(new_health: int, old_health: int, max_health: int)
signal died

@export var max_health: int = 100:
	set(value):
		max_health = max(1, value)
		if is_instance_valid(self):
			self.current_health = min(current_health, max_health)

@export var current_health: int = 100:
	set(value):
		var old_health = current_health
		current_health = clamp(value, 0, max_health)
		
		if current_health != old_health:
			health_changed.emit(current_health, old_health, max_health)
			
		if current_health <= 0 and old_health > 0:
			died.emit()

func _ready():
	self.current_health = max_health

func take_damage(amount: int):
	self.current_health -= amount

func heal(amount: int):
	self.current_health += amount

func is_alive() -> bool:
	return current_health > 0
