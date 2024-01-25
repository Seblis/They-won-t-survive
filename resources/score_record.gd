class_name ScoreRecord
extends Resource

var score: int = 0
var datetime: String = ""

func initiate_score(score_value: int):
	score = score_value
	datetime = Time.get_datetime_string_from_system()

static func compare(a: ScoreRecord, b: ScoreRecord):
	return a.score > b.score
