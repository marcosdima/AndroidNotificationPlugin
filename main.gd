extends Control

@export_group("Send Notification")
@export var channel: String = ""
@export var notification_object: Notification = Notification.new()
@export var delay: int = 0
@export_group("")

@onready var margin: Container = $Body

func _ready():
	call_deferred("_init_sizes")


func _init_sizes():
	var _size = get_parent_area_size()
	set_size(_size)
	margin.set_size(_size)


func _on_send_notification_pressed() -> void:
	NotificationNode.trigger_notification(
		channel,
		notification_object,
	)


func _on_image_pressed() -> void:
	NotificationNode.schedule(
		channel,
		NotificationWithImage.new()
			.set_image("small_icon.png")
			.set_basic_info("With Image", "Content with image", "small_icon.png", Notification.Priority.HIGH),
		delay,
	)


func _on_json_pressed() -> void:
	var init_noti = (NotificationLines.new()
		.set_lines(['New notification', 'NOT UPDATED'])
		.set_basic_info(
			"JSON",
			"JSON test",
			"small_icon.png",
			Notification.Priority.HIGH
	))
	var json_name = JSONHandler.get_json_path("on_json_pressed")
	JSONHandler.save_json(json_name, init_noti.as_dictionary())
	NotificationNode.schedule_json(channel, json_name, delay)
	init_noti.set_lines(['New NEW notification', 'JSON UPDATED!!!'] as Array[String])
	JSONHandler.save_json(json_name, init_noti.as_dictionary()) ## TODO


var aux_id: int = 0
func _on_create_pressed() -> void:
	var res = NotificationNode.schedule(
		channel,
		NotificationBigText.new()
			.set_big_text("This notification could have been canceled... but it survived.")
			.set_basic_info(
				"The survivor",
				"#1",
				"small_icon.png",
				Notification.Priority.HIGH,
			),
		delay,
	)
	var data = JSON.parse_string(res)
	var key = NotificationNode.NOTIFICATION_ID
	if data.has(key):
		aux_id = data[key]


func _on_delete_pressed() -> void:
	NotificationNode.cancel(aux_id)
	aux_id = 0


func _on_exit_pressed() -> void:
	get_tree().quit(0)
