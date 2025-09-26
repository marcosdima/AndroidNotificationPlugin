class_name JSONHandler

const BASE_PATH = "json/"
const USER = "user://"

static func save_json(name: String, data: Dictionary = {}) -> void:
	var path = USER + JSONHandler.get_json_path(name)
	
	# Check if the directories exist.
	DirAccess.make_dir_recursive_absolute(USER + BASE_PATH)
	
	var file = FileAccess.open(path, FileAccess.WRITE)
	if not file:
		var err = FileAccess.get_open_error()
		push_error("File error: %s (error %d)" % [path, err])
		return
	
	file.store_string(JSON.stringify(data, ""))
	file.close()


static func get_json_path(target: String) -> String:
	return BASE_PATH + target + ".json"
