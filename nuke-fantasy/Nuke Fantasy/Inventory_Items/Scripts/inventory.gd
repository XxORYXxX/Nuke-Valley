extends Resource

class_name Inventory
 
signal updated



@export var slots: Array[InventorySlot]

func freeSpace():
	pass
	
func use_item_at_index(index: int) -> void:
	if index < 0 or index >= slots.size() or !slots[index].item: return
	var slot = slots[index]
	
	if slot.amount > 1:
		slot.amount -= 1
		updated.emit() 
		return
			
	remove_at_index(index)
	


func insert(item: InventoryItem):
	for slot in slots:
		if slot.item == item && slot.amount < slot.item.maxAmountPrStack:
			slot.amount += 1;
			updated.emit();
			
			return;
	
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item;
			slots[i].amount = 1;
			updated.emit();
			return;
	
func removeSlot(inventorySlot:InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	remove_at_index(index)
	
func remove_at_index(index: int) -> void:
	slots[index] = InventorySlot.new()
	
	updated.emit();

func insertSlot(index:int, inventorySlot: InventorySlot):
	
	slots[index] = inventorySlot
	updated.emit();
	
	
