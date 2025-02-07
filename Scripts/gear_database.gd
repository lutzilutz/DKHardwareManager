extends Resource
class_name GearDatabase

@export var gears: Array = []

func add_new_gear(new_gear: Gear):
	var expected_id = 0
	for i in range(gears.size()):
		if i != gears[i].id:
			print("not equal, i=", i, ", id=", gears[i].id)
			expected_id = i
			break
		else:
			expected_id = i+1
	
	var tmp_gear = new_gear.duplicate()
	tmp_gear.id = expected_id
	
	gears.append(tmp_gear)
	gears.sort_custom(custom_sort)

static func load_save():
	return load(Utils.SAVE_PATH)

func clear_database():
	print("Database cleared")
	gears.clear()

func delete_gear(id_to_delete: int):
	var gear_id = -1
	for i in range(gears.size()):
		if gears[i].id == id_to_delete:
			gear_id = i
	
	if gear_id >= 0:
		gears.remove_at(gear_id)
	else:
		print("Couldn't find id to delete : ", id_to_delete)

func item_count():
	return gears.size()

func custom_sort(a, b):
	return a.id < b.id

func sort_gears(type: int, ascending: bool):
	match type:
		0:
			if ascending:
				gears.sort_custom(sort_by_id_ascending)
			else:
				gears.sort_custom(sort_by_id_descending)
		1:
			if ascending:
				gears.sort_custom(sort_by_brand_ascending)
			else:
				gears.sort_custom(sort_by_brand_descending)
		2:
			if ascending:
				gears.sort_custom(sort_by_model_ascending)
			else:
				gears.sort_custom(sort_by_model_descending)
		3:
			if ascending:
				gears.sort_custom(sort_by_cost_ascending)
			else:
				gears.sort_custom(sort_by_cost_descending)
		4:
			if ascending:
				gears.sort_custom(sort_by_quantity_ascending)
			else:
				gears.sort_custom(sort_by_quantity_descending)
		5:
			if ascending:
				gears.sort_custom(sort_by_category_ascending)
			else:
				gears.sort_custom(sort_by_category_descending)
		6:
			if ascending:
				gears.sort_custom(sort_by_need_loading_ascending)
			else:
				gears.sort_custom(sort_by_need_loading_descending)
		7:
			if ascending:
				gears.sort_custom(sort_by_comment_ascending)
			else:
				gears.sort_custom(sort_by_comment_descending)

func sort_by_id_ascending(a, b):
	return a.id < b.id
func sort_by_id_descending(a, b):
	return a.id >= b.id

func sort_by_brand_ascending(a, b):
	return a.brand < b.brand
func sort_by_brand_descending(a, b):
	return a.brand >= b.brand

func sort_by_model_ascending(a, b):
	return a.model < b.model
func sort_by_model_descending(a, b):
	return a.model >= b.model

func sort_by_cost_ascending(a, b):
	return a.cost < b.cost
func sort_by_cost_descending(a, b):
	return a.cost >= b.cost

func sort_by_quantity_ascending(a, b):
	return a.quantity < b.quantity
func sort_by_quantity_descending(a, b):
	return a.quantity >= b.quantity

func sort_by_category_ascending(a, b):
	var is_smaller = false
	if a.department_id < b.department_id:
		is_smaller = true
	elif a.department_id == b.department_id:
		if a.category_id < b.category_id:
			is_smaller = true
	return is_smaller
func sort_by_category_descending(a, b):
	return not sort_by_category_ascending(a, b)

func sort_by_need_loading_ascending(a, b):
	return a.need_loading < b.need_loading
func sort_by_need_loading_descending(a, b):
	return a.need_loading >= b.need_loading

func sort_by_comment_ascending(a, b):
	return a.comment < b.comment
func sort_by_comment_descending(a, b):
	return a.comment >= b.comment
