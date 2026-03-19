class_name HealthComponent
extends Node

signal health_changed(current: float, max: float)
signal died()

@export var max_health: float = 100.0

var current_health: float
var _is_dead: bool = false


func _ready() -> void:
	current_health = max_health


func take_damage(amount: float) -> void:
	if _is_dead:
		return

	current_health -= amount
	current_health = maxf(current_health, 0.0)
	health_changed.emit(current_health, max_health)

	if current_health <= 0.0:
		_is_dead = true
		died.emit()


func heal(amount: float) -> void:
	if _is_dead:
		return

	current_health += amount
	current_health = minf(current_health, max_health)
	health_changed.emit(current_health, max_health)


func reset() -> void:
	_is_dead = false
	current_health = max_health
