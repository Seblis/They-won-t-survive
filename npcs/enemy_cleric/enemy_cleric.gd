extends CharacterBody2D

const SPEED: float = 125.0
const DESIRED_RANGE: float = 72.0

enum State {WALK, BLESS, DEATH}
var state: int = State.WALK

func _ready():
	pass

func _physics_process(_delta):
	pass

func _initiate_walk():
	# TODO: search for corrupted tile
	state = State.WALK

func _update_walk():
	pass

func _initiate_bless():
	state = State.BLESS

func _update_bless():
	pass

func _on_entity_died():
	state = State.DEATH
	# TODO: play death animation, queue free after animation is finished
	queue_free()
