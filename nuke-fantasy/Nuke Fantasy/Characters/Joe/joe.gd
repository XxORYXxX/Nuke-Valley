extends CharacterBody2D

@export var move_speed : float = 100;

@export var runy_speed : float = 150;

@export var starting_dir : Vector2 = Vector2(0,1);

@onready var animation_tree = $AnimationTree;
@onready var state_machine = animation_tree.get("parameters/playback");



func _ready():
	update_animation_parameters(starting_dir);

func _physics_process(_delta):
	var input_dir = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized();
	
	update_animation_parameters(input_dir);
	
	velocity = input_dir * move_speed;
	
	move_and_slide();
	
	pick_new_state();

func update_animation_parameters(move_input : Vector2):
	
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Run/blend_position",move_input);
		animation_tree.set("parameters/Walk/blend_position",move_input);
		animation_tree.set("parameters/Idle/blend_position",move_input);
func pick_new_state():
	if(velocity != Vector2.ZERO):
		if (Input.get_action_strength("Run")):
			state_machine.travel("Run");
			move_speed = runy_speed
		else:
			state_machine.travel("Walk");
			move_speed = 100;
	else:
		state_machine.travel("Idle");
	
		

	
@export var inventory: Inventory;
