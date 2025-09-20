class_name JSONHandler

const BASE_PATH = "json/"

static func save_json(name: String, data: Dictionary = {}) -> void:
	var path = "user://" + JSONHandler.get_json_path(name)
	
	# Check if the directories exist.
	DirAccess.make_dir_recursive_absolute("user://" + BASE_PATH)
	
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		var err = FileAccess.get_open_error()
		push_error("No se pudo abrir el archivo: %s (error %d)" % [path, err])
		return
	
	file.store_string(JSON.stringify(data, ""))
	file.close()


static func get_json_path(target: String) -> String:
	return BASE_PATH + target + ".json"
