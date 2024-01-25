extends HBoxContainer

@export var default_column_id: String = ""
@export var default_datetime: String = ""
@export var default_score: String = ""

@onready var column_label: Label = $ColumnID
@onready var datetime_label: Label = $DateTime
@onready var score_label: Label = $Score

# Called when the node enters the scene tree for the first time.
func _ready():
	set_row_data(default_column_id, default_datetime, default_score)


func set_row_data(row_id: String, row_date: String, row_score: String):
	column_label.text = row_id
	datetime_label.text = row_date
	score_label.text = row_score
