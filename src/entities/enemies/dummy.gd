class_name Dummy
extends CharacterBody2D

const GEM_SCENE: PackedScene = preload("res://src/entities/loot/experience_gem.tscn")

@export var move_speed: float = 100.0

@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var _player: Node2D


func _ready() -> void:
	health_component.health_changed.connect(_on_health_changed)
	health_component.died.connect(_on_died)


func _physics_process(_delta: float) -> void:
	if not is_instance_valid(_player):
		return

	var direction: Vector2 = global_position.direction_to(_player.global_position)
	velocity = direction * move_speed
	move_and_slide()


func activate(spawn_position: Vector2) -> void:
	global_position = spawn_position
	_player = get_tree().get_first_node_in_group("player") as Node2D
	health_component.reset()
	show()
	process_mode = Node.PROCESS_MODE_INHERIT
	collision_shape.set_deferred("disabled", false)


func deactivate() -> void:
	_player = null
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	collision_shape.set_deferred("disabled", true)


func _on_health_changed(current: float, max_health: float) -> void:
	print("Dummy took damage! HP: %s/%s" % [current, max_health])

	var tween: Tween = create_tween()
	sprite.modulate = Color.RED
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.2)


func _on_died() -> void:
	print("Dummy died!")
	var gem: Node2D = GEM_SCENE.instantiate() as Node2D
	gem.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", gem)
	deactivate.call_deferred()
