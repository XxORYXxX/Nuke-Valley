extends Area2D


var joe = null;


@export var itemRes: InventoryItem


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Main_One" && !Input.get_action_strength("Run"):
		collect(body.inventory);


func collect(inventory: Inventory):
	queue_free()
	inventory.insert(itemRes)


	
	







	
	
