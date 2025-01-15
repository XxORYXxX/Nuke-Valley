extends Panel

@onready var inventory: Inventory = preload("res://Nuke Fantasy/Inventory_Items/Items'/Inv.tres");

@onready var ItemStackGuiClass = preload("res://Nuke Fantasy/Inventory_Items/item_stack_gui.tscn");

@onready var slots: Array = $Container/NinePatchRect/Slots.get_children();

@onready var sellector: Sprite2D = $Sellector

var curren_sellect: int = 0

var curren_space: int = slots.size()

var itenInHand: ItemStackGui;


	
func move_selector_up() -> void:
	curren_sellect = (curren_sellect + 1 ) % slots.size()
	sellector.global_position = slots[curren_sellect].global_position
func move_selector_down() -> void:
	curren_sellect = (curren_sellect - 1 ) % slots.size()
	sellector.global_position = slots[curren_sellect].global_position

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Drop"):
		inventory.use_item_at_index(curren_sellect)
	if event.is_action_pressed("Sellect_up"):
		move_selector_up()
	elif event.is_action_pressed("sellect_down"):
		move_selector_down()
func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()
	
func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		var callable = Callable(onSlotClick)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		if !inventorySlot.item:
			slots[i].clear()
			continue
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		if !itemStackGui: 
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
		itemStackGui.inventorySlot =inventorySlot
		itemStackGui.update()
			


func onSlotClick(slot):
	if slot.isEmpty():
		if !itenInHand: return
		insertItemInSlot(slot)
		return
		
	if !itenInHand:
		takeItemFromSlot(slot)
		return
	if slot.itemStackGui.inventorySlot.item.name == itenInHand.inventorySlot.item.name:
		stackItems(slot)
		return
	swapItem(slot)
	
	
func takeItemFromSlot(slot):
	itenInHand = slot.takeItem()
	add_child(itenInHand)
	updateItemInHand()
	
func insertItemInSlot(slot):
	var item = itenInHand
	
	remove_child(itenInHand)
	itenInHand = null
	slot.insert(item)

func swapItem(slot):
	var tempItem = slot.takeItem()
	insertItemInSlot(slot)
	itenInHand = tempItem
	add_child(itenInHand)
	updateItemInHand()

func stackItems(slot):
	var slotItem: ItemStackGui = slot.itemStackGui
	var maxAmount = slotItem.inventorySlot.item.maxAmountPrStack
	var totalAmount = slotItem.inventorySlot.amount + itenInHand.inventorySlot.amount
	
	if slotItem.inventorySlot.amount == maxAmount:
		swapItem(slot)
		return
	if totalAmount <= maxAmount:
		slotItem.inventorySlot.amount = totalAmount
		remove_child(itenInHand)
		itenInHand = null
		
	else:
		slotItem.inventorySlot.amount = maxAmount
		itenInHand.inventorySlot.amount = totalAmount - maxAmount
	slotItem.update()
	if itenInHand: itenInHand.update()
	
func updateItemInHand():
	if !itenInHand: return
	itenInHand.global_position = get_global_mouse_position() - itenInHand.size / 2

func _input(event):
	updateItemInHand()
