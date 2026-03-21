class_name Player
extends CharacterBody2D

signal exp_changed(current_exp: float, max_exp: float)
signal leveled_up(new_level: int)

@export var move_speed: float = 300.0

var current_level: int = 1
var current_exp: float = 0.0
var exp_cap: float = 100.0

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
	current_exp += amount

	while current_exp >= exp_cap:
		current_exp -= exp_cap
		current_level += 1
		exp_cap *= 1.2
		leveled_up.emit(current_level)

	exp_changed.emit(current_exp, exp_cap)


func _on_pickup_area_entered(area: Area2D) -> void:
	if area is ExperienceGem:
		area.fly_to(self)
