extends Control

@export_group("Send Notification")
@export var channel_index: int = 0
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
	$NotificationHandler.trigger_notification(
		channel_index,
		notification_object,
		delay,
	)

func _on_image_pressed() -> void:
	$NotificationHandler.trigger_notification(
		channel_index,
		NotificationWithImage.new()
			.set_image("small_icon.png")
			.set_basic_info("With Image", "Content with image", "small_icon.png", Notification.Priority.HIGH),
		delay,
	)


func _on_exit_pressed() -> void:
	get_tree().quit(0)
