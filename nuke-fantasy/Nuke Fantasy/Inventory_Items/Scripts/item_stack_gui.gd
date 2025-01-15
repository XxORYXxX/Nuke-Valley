extends Panel

class_name ItemStackGui

@onready var itemSprite: Sprite2D = $Item
@onready var amount_label: Label = $Label

var inventorySlot: InventorySlot;


func  update():
	if !inventorySlot or !inventorySlot.item: return
	itemSprite.visible = true;
	itemSprite.texture = inventorySlot.item.texture;
	if inventorySlot.amount && !inventorySlot.item.equip:
		amount_label.visible = true
		amount_label.text = str(inventorySlot.amount)
		
	else:
		amount_label.visible = false
