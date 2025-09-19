extends NotificationResult
class_name NotificationError

const ERROR = "errCode"

enum Error {
	VOID = 1,
	NO_CONTEXT = 2,
	NO_SETUP = 3,
	INVALID_NOTIFICATION_DATA = 4,
	JSON_ERROR = 5,
	IMAGE_NOT_FOUND = 6,
}

var code: NotificationError.Error

func _init(set_code: int):
	code = set_code


func _to_string() -> String:
	return "Error: %s" % Error.find_key(code)
