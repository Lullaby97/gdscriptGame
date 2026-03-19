class_name Player
extends CharacterBody2D

@export var move_speed: float = 300.0

@onready var pickup_area: Area2D = $PickupArea


func _ready() -> void:
	velocity = Vector2.ZERO
	set_physics_process(false)
	get_tree().create_timer(0.1).timeout.connect(func() -> void: set_physics_process(true))
	pickup_area.area_entered.connect(_on_pickup_area_entered)


func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * move_speed
	move_and_slide()


func add_exp(amount: float) -> void:
	print("Player gained EXP: ", amount)


func _on_pickup_area_entered(area: Area2D) -> void:
	if area is ExperienceGem:
		area.fly_to(self)
