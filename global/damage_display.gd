extends Node

const DAMAGE_LABEL = preload("res://components/damage_label.tscn")
const LABEL_OFFSET: Vector2 = Vector2(10,-10)

# Called when the node enters the scene tree for the first time.
func display_number(value: int, position: Vector2, is_critical: bool = false):
	var new_label = DAMAGE_LABEL.instantiate()
	new_label.text = str(value)
	new_label.global_position = position + LABEL_OFFSET
	call_deferred("add_child", new_label)
