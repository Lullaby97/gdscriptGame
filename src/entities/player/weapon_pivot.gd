class_name WeaponPivot
extends Node2D

@export var rotation_speed: float = 180.0


func _physics_process(delta: float) -> void:
	rotation += deg_to_rad(rotation_speed) * delta
