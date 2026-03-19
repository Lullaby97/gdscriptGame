class_name Dummy
extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	health_component.health_changed.connect(_on_health_changed)
	health_component.died.connect(_on_died)


func activate(spawn_position: Vector2) -> void:
	global_position = spawn_position
	health_component.reset()
	show()
	process_mode = Node.PROCESS_MODE_INHERIT
	collision_shape.set_deferred("disabled", false)


func deactivate() -> void:
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
	deactivate.call_deferred()
