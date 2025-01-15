extends Button

@onready var container: CenterContainer = $CenterContainer
@onready var inventory = preload("res://Nuke Fantasy/Inventory_Items/Items'/Inv.tres")

var itemStackGui:ItemStackGui
var index: int


func insert(isg: ItemStackGui):
	itemStackGui = isg;
	container.add_child(itemStackGui);
	
	if !itemStackGui.inventorySlot or inventory.slots[index] == itemStackGui.inventorySlot:

		return
		
	inventory.insertSlot(index, itemStackGui.inventorySlot)

func takeItem():
	var item = itemStackGui;
	inventory.removeSlot(itemStackGui.inventorySlot)
	
	
	return item
	
	
func isEmpty():
	return !itemStackGui


func clear() -> void:
	if  itemStackGui:
		container. remove_child(itemStackGui)
		itemStackGui = null
	
