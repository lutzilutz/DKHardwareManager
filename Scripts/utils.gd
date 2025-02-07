extends Node

const SAVE_PATH = "res://Data/gear_database_001.tres"

#enum Category {
	#UNKNOWN,
	#CAMERA,
	#SOUND,
	#LIGHT,
	#MISC
#}

enum Department {
	PHOTO,
	SOUND,
	VFX,
	DIRECTING,
	MISC
}

enum PhotoCategory {
	CAMERA,
	LENS,
	BATTERY
}

enum SoundCategory {
	RECORDER,
	MIC,
	CABLE,
	PERCH
}

enum VFXCategory {
	KEYING
}

enum DirectingCategory {
	MISC
}

enum MiscCategory {
	MISC
}

enum User {
	KAREL,
	LUTZ,
	YANN
}

var grid_button_normal = load("res://Themes/grid_button_normal.tres")
var grid_button_highlighted = load("res://Themes/grid_button_highlighted.tres")

#static func get_department_categories():
	#return PhotoCategory

func category_id_to_string(dep_id: int, cat_id: int, full_name: bool):
	var category: String = ""
	if full_name:
		category = "Unknown"
		category = Utils.department_id_to_string(dep_id) + " - "
	
	match dep_id:
		0:
			match cat_id:
				0:
					category += "Camera"
				1:
					category += "Lens"
				2:
					category += "Battery"
				_:
					category += "Unknown"
		1:
			match cat_id:
				0:
					category += "Recorder"
				1:
					category += "Mic"
				2:
					category += "Cable"
				3:
					category += "Perch"
				_:
					category += "Unknown"
		2:
			match cat_id:
				0:
					category += "Keying"
				_:
					category += "Unknown"
		3:
			match cat_id:
				0:
					category += "Misc"
				_:
					category += "Unknown"
		4:
			match cat_id:
				0:
					category += "Misc"
				_:
					category += "Unknown"
	
	return category
	#match id:
		#0:
			#return "Unkown"
		#1:
			#return "Camera"
		#2:
			#return "Sound"
		#3:
			#return "Light"
		#4:
			#return "Misc"

func get_department_subcategories(id):
	match id:
		0:
			return Utils.PhotoCategory
		1:
			return Utils.SoundCategory
		2:
			return Utils.VFXCategory
		3:
			return Utils.DirectingCategory
		4:
			return Utils.MiscCategory
		_:
			print("Unknown department ID in get_department_subcategories() : ", id)

func department_id_to_string(id: int):
	match id:
		0:
			return "Photo"
		1:
			return "Sound"
		2:
			return "VFX"
		3:
			return "Directing"
		4:
			return "Misc"
		_:
			print("Unkown departement ID in department_id_to_string() : ", id)
			return "Unknown"

func user_id_to_string(id: int):
	match id:
		0:
			return "Karel"
		1:
			return "Lutz"
		2:
			return "Yann"
		_:
			print("Unkown user ID in user_id_to_string() : ", id)
			return "Unknown"
