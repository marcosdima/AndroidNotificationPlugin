extends Resource
class_name Channel

const Fields = {
	"CHANNEL_ID": "channelId",
	"CHANNEL_NAME": "name",
	"DESCRIPTION": "description",
	"IMPORTANCE": "importance"
}

enum Importance {
	NONE = 0,
	MIN = 1,
	LOW = 2,
	DEFAULT = 3,
	HIGH = 4
}

@export var channel_id: String = ""
@export var channel_name: String = ""
@export var description: String = ""
@export var importance: Importance = Importance.DEFAULT

func as_dictionary() -> Dictionary:
	return {
		Fields.CHANNEL_ID: channel_id,
		Fields.CHANNEL_NAME: channel_name,
		Fields.DESCRIPTION: description,
		Fields.IMPORTANCE: importance,
	}
