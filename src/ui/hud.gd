class_name HUD
extends CanvasLayer

@onready var exp_bar: ProgressBar = $ExpBar
@onready var level_label: Label = $LevelLabel
@onready var player: Player = owner as Player


func _ready() -> void:
	if not is_instance_valid(player):
		push_error("HUD: owner is not a valid Player. Ensure HUD is a child of Player in player.tscn.")
		return

	player.exp_changed.connect(_on_player_exp_changed)
	player.leveled_up.connect(_on_player_leveled_up)

	exp_bar.value = 0.0
	exp_bar.max_value = player.exp_cap
	level_label.text = "LV. 1"


func _on_player_exp_changed(current: float, max_val: float) -> void:
	exp_bar.value = current
	exp_bar.max_value = max_val


func _on_player_leveled_up(new_level: int) -> void:
	level_label.text = "LV. " + str(new_level)
	print("LEVEL UP! Now Level: ", new_level)
