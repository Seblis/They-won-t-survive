class_name HighScoreTable
extends Control

const TABLE_ROW: PackedScene = preload("res://levels/scores_screen/table_row.tscn")

@onready var table_rows = $TableMargins/TableRowMargins/TableRows
var entry_list: HighScoreList

# Called when the node enters the scene tree for the first time.
func _ready():
	entry_list = HighScoreList.load_highscores()
	var col_id = 0
	
	if entry_list != null:
		for entry in entry_list.high_scores:
			col_id += 1
			create_new_data_row(col_id, entry.datetime, entry.score)

func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_ESCAPE:
			get_viewport().set_input_as_handled()
			queue_free()

func create_new_data_row(id: int, data: String, score: int):
	var new_data_row = TABLE_ROW.instantiate()
	table_rows.add_child(new_data_row)
	new_data_row.set_row_data(str(id), data, str(score))
