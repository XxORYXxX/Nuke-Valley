extends Label
# Supongamos que tienes un Label llamado "ScoreLabel"
@onready var score_label: Label = $ScoreLabel
var score: int = 0

func _ready():
	update_score_display()

func update_score_display():
	score_label.text = str(score)  # Convierte el valor numérico a texto y lo asigna
