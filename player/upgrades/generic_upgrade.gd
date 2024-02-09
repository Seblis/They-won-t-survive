extends TextureButton
class_name GenericUpgrade

@export var _title: String = "title"
@export var _desc: String = "description"

func _ready():
	$MarginContainer/VBoxContainer/Title.text = _title
	$MarginContainer/VBoxContainer/Description.text = _desc
