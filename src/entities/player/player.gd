class_name Player
extends CharacterBody2D

@export var move_speed: float = 300.0


func _ready() -> void:
	velocity = Vector2.ZERO
	set_physics_process(false)
	get_tree().create_timer(0.1).timeout.connect(func() -> void: set_physics_process(true))


func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * move_speed
	move_and_slide()
