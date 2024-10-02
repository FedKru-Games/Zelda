class_name InventoryCell extends Resource

var content: ItemStack = null

func is_empty() -> bool:
	return content == null
