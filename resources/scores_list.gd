class_name HighScoreList
extends Resource

const HIGH_SCORES_PATH: String = "user://highscores.tres"
const ENTRY_AMOUNT: int = 10

@export var high_scores: Array[Resource] = []

func register_new_score(score: int):
	var new_score: ScoreRecord = ScoreRecord.new()
	new_score.initiate_score(score)
	high_scores.append(new_score)
	high_scores.sort_custom(ScoreRecord.compare)
	if high_scores.size() > ENTRY_AMOUNT:
		high_scores.remove_at(ENTRY_AMOUNT)
	save_highscores()

func save_highscores():
	print("attempt to save high score")
	print("Size ", high_scores.size())
	print(ResourceSaver.save(self, HIGH_SCORES_PATH))

static func load_highscores():
	if ResourceLoader.exists(HIGH_SCORES_PATH):
		return load(HIGH_SCORES_PATH)
	else:
		return HighScoreList.new()
