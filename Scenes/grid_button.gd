class_name GridButton
extends Button

signal row_hovered(row_id)
signal row_selected(row_id)

var row_id: int = -1
var column_id: int = -1
var column_size: int = 0
var is_highlighted: bool = false
var stylebox_theme_default = get_theme_stylebox("normal").duplicate()
var stylebox_theme_highlighted = get_theme_stylebox("normal").duplicate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#add_theme_stylebox_override("normal", Utils.grid_button_normal)
	#set_column_size(10)
	var hl_color = stylebox_theme_default.bg_color
	hl_color.r *= 2.5
	hl_color.g *= 2.5
	hl_color.b *= 2.5
	stylebox_theme_highlighted.bg_color = hl_color
	
	add_theme_stylebox_override("disabled", stylebox_theme_default)
	add_theme_stylebox_override("focus", stylebox_theme_default)
	add_theme_stylebox_override("hover", stylebox_theme_default)
	add_theme_stylebox_override("hover_pressed", stylebox_theme_default)
	add_theme_stylebox_override("normal", stylebox_theme_default)
	add_theme_stylebox_override("pressed", stylebox_theme_default)
	
	mouse_entered.connect(_on_hovering)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_highlighted(new_highlighted):
	
	is_highlighted = new_highlighted
	
	if is_highlighted:
		add_theme_stylebox_override("disabled", stylebox_theme_highlighted)
		add_theme_stylebox_override("focus", stylebox_theme_highlighted)
		add_theme_stylebox_override("hover", stylebox_theme_highlighted)
		add_theme_stylebox_override("hover_pressed", stylebox_theme_highlighted)
		add_theme_stylebox_override("normal", stylebox_theme_highlighted)
		add_theme_stylebox_override("pressed", stylebox_theme_highlighted)
	else:
		add_theme_stylebox_override("disabled", stylebox_theme_default)
		add_theme_stylebox_override("focus", stylebox_theme_default)
		add_theme_stylebox_override("hover", stylebox_theme_default)
		add_theme_stylebox_override("hover_pressed", stylebox_theme_default)
		add_theme_stylebox_override("normal", stylebox_theme_default)
		add_theme_stylebox_override("pressed", stylebox_theme_default)

func set_column_size(new_size):
	column_size = new_size
	custom_minimum_size.x = column_size

func set_row_id(new_id):
	row_id = new_id

func set_column_id(new_id):
	column_id = new_id

func _pressed() -> void:
	emit_signal("row_selected", row_id)

func _on_hovering():
	emit_signal("row_hovered", row_id)
