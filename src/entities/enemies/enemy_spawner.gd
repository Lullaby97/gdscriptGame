class_name EnemySpawner
extends Node2D

@export var enemy_scene: PackedScene
@export var player: Node2D
@export var pool_size: int = 50
@export var spawn_radius: float = 800.0
@export var spawn_interval: float = 0.5

const _GRAVEYARD_POSITION: Vector2 = Vector2(-10000, -10000)

var _pool: Array[Node2D] = []
var _spawn_timer: Timer


func _ready() -> void:
	for i: int in pool_size:
		var instance: Node2D = enemy_scene.instantiate() as Node2D
		instance.position = _GRAVEYARD_POSITION
		instance.process_mode = Node.PROCESS_MODE_DISABLED
		add_child(instance)
		if instance.has_method("deactivate"):
			instance.deactivate()
		_pool.append(instance)

	_spawn_timer = Timer.new()
	_spawn_timer.wait_time = spawn_interval
	_spawn_timer.autostart = true
	add_child(_spawn_timer)
	_spawn_timer.timeout.connect(_on_spawn_timer_timeout)


func _on_spawn_timer_timeout() -> void:
	if not is_instance_valid(player):
		return

	var inactive_entity: Node2D = _find_inactive()
	if inactive_entity == null:
		return

	var angle: float = randf() * TAU
	var spawn_position: Vector2 = Vector2.RIGHT.rotated(angle) * spawn_radius + player.global_position
	inactive_entity.activate(spawn_position)


func _find_inactive() -> Node2D:
	for entity: Node2D in _pool:
		if entity.process_mode == Node.PROCESS_MODE_DISABLED:
			return entity
	return null
