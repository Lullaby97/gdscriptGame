class_name GameCamera
extends Camera2D

@export var shake_noise: FastNoiseLite


func apply_screen_shake(intensity: float, duration: float) -> void:
	print("Screen shake triggered with intensity: ", intensity)
