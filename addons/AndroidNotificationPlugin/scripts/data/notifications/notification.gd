extends Resource
class_name Notification

const Fields = {
	TITLE = "title",
	CONTENT = "content",
	SMALL_ICON = "smallIcon",
	PRIORITY = "priority"
}

enum Priority {
	MIN = -2,
	LOW = -1,
	DEFAULT = 0,
	HIGH = 1,
	MAX = 2
}

@export var title: String
@export var content: String
@export var small_icon: String = "small_icon"
@export var priority: Priority = Priority.DEFAULT

func set_basic_info(
	_title: String,
	_content: String,
	_small_icon: String,
	_priority: Priority,
) -> Notification:
	title = _title
	content = _content
	small_icon = _small_icon
	priority = _priority
	return self


# Return the data as a dictionary
func as_dictionary() -> Dictionary:
	if small_icon.is_empty() or content.is_empty() or title.is_empty():
		var keys = Fields.values().filter(func(val): return val != "priority")
		printerr("This fields are a must: ", ", ".join(keys), ".")
		return {}
	
	return {
		Fields.TITLE: title,
		Fields.CONTENT: content,
		Fields.SMALL_ICON: small_icon,
		Fields.PRIORITY: priority
	}


# Return the dictionary as a JSON string
func as_string() -> String:
	return JSON.stringify(self.as_dictionary())
