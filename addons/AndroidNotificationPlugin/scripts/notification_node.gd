@tool
extends Node
class_name NotificationNode

const NOTIFICATION_ID = 'notificationId'

static var _instance: NotificationNode
var _plugin

@export var images: Array[Imagen] = []
@export var channels: Array[Channel] = []
var on_editor: bool:
	get():
		return Engine.is_editor_hint()
var setup_flag: bool = false  

# # Plugin interfaces # #

## Set up routine.
func setup() -> void:
	if _plugin:
		var channels_array = JSON.stringify(channels.map(func(ch): return ch.as_dictionary()))
		var images_array = JSON.stringify(images.map(func(i: Imagen): return i.save_name))
		var res = _plugin.setup(channels_array, images_array)
		setup_flag = true


## Send a notification.
static func trigger_notification(
	channel: String,
	notification_data: Notification,
) -> String:
	if !was_setted(): return ""
	if !validate_channel_id(channel): return ""
	var data: String = notification_data.as_string()
	return _instance._plugin.triggerNotification(channel, data)


## Send a notification loaded from a json.
static func json_notification(
	channel: String,
	json_name: String,
) -> String:
	if !was_setted(): return ""
	if (!validate_channel_id(channel)): return ""
	return _instance._plugin.jsonNotification(
		channel,
		JSONHandler.get_json_path(json_name),
	)


## Schedule a notification.
static func schedule(
	channel: String,
	notification_data: Notification,
	past_n_seconds: int = 0
) -> String:
	if !was_setted(): return ""
	if !validate_channel_id(channel): return ""
	var data: String = notification_data.as_string()
	return _instance._plugin.schedule(channel, data, past_n_seconds)


## Schedule a notification loaded from a json.
static func schedule_json(
	channel: String,
	json_name: String,
	past_n_seconds: int = 0
) -> String:
	if !was_setted(): return ""
	if !validate_channel_id(channel): return ""
	return _instance._plugin.scheduleJson(
		channel,
		json_name,
		past_n_seconds,
	)


## Cancel a scheduled notificaton o close it if it was already sended.
static func cancel(
	notification_id: int
) -> String:
	if !was_setted(): return ""
	return _instance._plugin.cancel(notification_id)

# # Plugin interfaces # #

func _ready() -> void:
	if _instance:
		return printerr("This class should only be instantiated once!")
	self.plugin_exists()
	
	# Save images.
	if !on_editor:
		for image: Imagen in images:
			var img = image.texture.get_image()
			var err = img.save_png("user://" + image.save_name)
			if err != OK:
				print("error: ", image.save_name)
	
	self.call_deferred("setup")
	_instance = self


static func validate_channel_id(id: String) -> bool:
	var index = _instance.channels.find_custom(
		func(ch: Channel): 
			return ch.channel_id == id
	)
	var valid = index >= 0
	if !valid:
		var ids = _instance.channels.map(func(ch: Channel): return ch.channel_id)
		printerr("Invalid channel id '%s'. Ids: %s" % [id, ids])
	return valid


static func was_setted() -> bool:
	if !_instance:
		printerr("Instance must be setted!")
		return false
	elif !_instance.setup_flag:
		printerr("Setup must be called first!")
	return _instance.setup_flag


func plugin_exists() -> void:
	var _plugin_name: String = "NotificationHandler"
	if Engine.has_singleton(_plugin_name):
		_plugin = Engine.get_singleton(_plugin_name)
	else:
		printerr("Couldn't find plugin " + _plugin_name)
