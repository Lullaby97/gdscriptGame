class_name ExperienceGem
extends Area2D

@export var exp_value: float = 10.0
@export var acceleration: float = 1200.0
@export var max_speed: float = 800.0

var _target: Node2D = null
var _current_speed: float = 0.0


func fly_to(target: Node2D) -> void:
	_target = target


func _physics_process(delta: float) -> void:
	if not is_instance_valid(_target):
		return

	_current_speed = move_toward(_current_speed, max_speed, acceleration * delta)
	global_position = global_position.move_toward(_target.global_position, _current_speed * delta)

	if global_position.distance_to(_target.global_position) < 10.0:
		_target.add_exp(exp_value)
		queue_free()
