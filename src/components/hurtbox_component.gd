class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if not area is HitboxComponent:
		return

	if not is_instance_valid(health_component):
		return

	var hitbox: HitboxComponent = area as HitboxComponent
	health_component.take_damage(hitbox.damage)
