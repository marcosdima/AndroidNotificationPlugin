@tool
extends Node
class_name NotificationHandler

var instance: NotificationHandler
var _plugin

@export var images: Array[Imagen] = []
@export var channels: Array[Channel] = []
var on_editor: bool:
	get():
		return Engine.is_editor_hint()
var setup_flag: bool = false  

## Plugin interfaces ##
func setup() -> void:
	if _plugin:
		var channels_array = JSON.stringify(channels.map(func(ch): return ch.as_dictionary()))
		_plugin.setup(channels_array)
		setup_flag = true


## Sends a notification past n seconds.
func trigger_notification(
	channels_index: int,
	notification_data: Notification,
	past_n_seconds: int = 0
) -> int:
	if !self.setup_called(): return -1
	var channel_id = channels[channels_index].channel_id
	var data: String = notification_data.as_string()
	return _plugin.triggerNotification(channel_id, data, past_n_seconds)
## Plugin interfaces ##


func _ready() -> void:
	self.plugin_exists()
	
	# Save images.
	if !on_editor:
		for image in images:
			var img = image.texture.get_image()
			img.save_png("user://" + image.save_name + '.png')
	
	self.call_deferred("setup")


func plugin_exists() -> void:
	var _plugin_name: String = "NotificationHandler"
	if Engine.has_singleton(_plugin_name):
		_plugin = Engine.get_singleton(_plugin_name)
	else:
		printerr("Couldn't find plugin " + _plugin_name)


func setup_called() -> bool:
	if !setup_flag:
		printerr("Setup must be called first!")
	return setup_flag
