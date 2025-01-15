extends CanvasLayer

var Vis_B = false;
var Vis_I = false;

@onready var book: NinePatchRect = $NinePatchRect
@onready var Items: GridContainer = $Items

var Tools = false
var Food = false 

func _ready():
	visible()
	Tools = true


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Book") && Vis_B:
		Vis_B = false
		visible()
	elif event.is_action_pressed("Book") && !Vis_B:
		Vis_B = true
		visible()
		
func _on_book_pressed() -> void:
	if Vis_B:
		Vis_B = false
		visible()
	else:
		Vis_B = true
		visible()

func visible():
	if Vis_B:
		
		book.visible = true;
	else:
		book.visible = false;
	
