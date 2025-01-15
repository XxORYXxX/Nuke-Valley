extends Button


@onready var container: CenterContainer = $CenterContainer
@onready var inventory = preload("res://Nuke Fantasy/Inventory_Items/Items'/Inv.tres")

var itemStackGui:ItemStackGui
var index: int


func takeItem():
	var item = itemStackGui;
	inventory.removeSlot(itemStackGui.handSlot)
	container. remove_child(itemStackGui)
	itemStackGui = null
	
	return item
	
	
func isEmpty():
	return !itemStackGui
