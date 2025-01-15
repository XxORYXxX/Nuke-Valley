class_name ToolItem extends InventoryItem

@export var tool_class: PackedScene = preload("res://Nuke Fantasy/Objects/Scene/Axe.tscn")

var tool

func _init() -> void:
	tool = tool_class.instantiate()
