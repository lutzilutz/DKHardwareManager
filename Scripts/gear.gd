extends Node
class_name Gear

@export var id: int = -1: set = set_id
@export var brand: String = "": set = set_brand
@export var model: String = "": set = set_model
@export var cost: int = 0: set = set_cost
@export var quantity: int = 0: set = set_quantity
@export var department_id: int = 0: set = set_department_id
@export var category_id: int = 0: set = set_category_id
@export var need_loading: bool = false: set = set_need_loading
@export var comment: String = "": set = set_comment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

##### Setters ################################################################

func set_id(new_id: int):
	id = new_id

func set_brand(new_brand: String):
	brand = new_brand

func set_model(new_model: String):
	model = new_model

func set_cost(new_cost: int):
	cost = new_cost

func set_quantity(new_quantity: int):
	quantity = new_quantity

func set_department_id(new_department: int):
	department_id = new_department

func set_category_id(new_category: int):
	category_id = new_category

func set_need_loading(new_need_loading: bool):
	need_loading = new_need_loading

func set_comment(new_comment: String):
	comment = new_comment
