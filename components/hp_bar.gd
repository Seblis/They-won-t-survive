extends ProgressBar

@onready var player = $"../../Player"
@onready var hp_bar = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	var stylebox = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", stylebox)
	stylebox.bg_color = Color("750000")
	SignalManager.on_player_health_updated.connect(_update_bar)
	hp_bar.max_value = player.get_node("HealthComponent").MAX_HEALTH
	hp_bar.value = hp_bar.max_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update_bar(value:int):
	hp_bar.value = value
