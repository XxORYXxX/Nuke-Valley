class_name Health
extends Node


signal  max_health_changed(diff: int);
signal health_changed(diff: int);
signal health_depleted;


@export var max_health: int = 100 : set = set_max_health, get = get_max_health;
@export var inmune : bool = false : set = set_inmune, get = get_inmune;
var inmune_timer : Timer = null;
@onready var health : int = max_health : set = set_health, get = get_health;

func set_max_health(value: int):
	
	var clamped_value = 1 if value <= 0 else value
	
	if clamped_value != max_health:
		
		var difference = clamped_value - max_health;
		max_health = value;
		max_health_changed.emit(difference);
		
		if health > max_health:
			health = max_health;
			
func get_max_health() -> int:
	
	
	return max_health;
func set_inmune(value: bool):
	
	inmune = value;
func get_inmune() -> bool:
	return inmune;
	
func set_tempor_inmune(time: float):
	if inmune_timer == null:
		inmune_timer = Timer.new();
		inmune_timer.one_shot = true;
		add_child(inmune_timer);
		
	if inmune_timer.timeout.is_connected(set_inmune):
		inmune_timer.timeout.disconnect(set_inmune);
		
	inmune_timer.set_wait_time(time);
	inmune_timer.timeout.connect(set_inmune.bind(false));
	inmune = true;
	inmune_timer.start();
	


func set_health(value: int):
	
	if value < health and inmune:
		return;
	var clamped_value = clampi(value, 0, max_health);
	
	if clamped_value != health:
		var difference = clamped_value - health;
		health = value
		health_changed.emit(difference);
		if health == 0:
			health_depleted.emit()
			
	pass;
	
func get_health():
	
	return health;

	
	
	
	
