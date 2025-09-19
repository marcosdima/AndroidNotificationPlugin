class_name NotificationResult

static func parse(res: String) -> NotificationResult:
	var parsed = JSON.parse_string(res)
	if !parsed:
		printerr("JSON error: ", res)
		return null
	
	var err_code = parsed.get(NotificationError.ERROR)
	if err_code:
		return NotificationError.new(err_code)
	
	var notification_id = parsed.get(NotificationCreated.NOTIFICATION_ID)
	if notification_id:
		return NotificationCreated.new(notification_id)
	
	return NotificationError.new(NotificationError.Error.VOID)
