extends Notification
class_name NotificationWithImage

const IMAGE = "image"
var image: String = ""

func set_image(_image: String) -> Notification:
	image = _image
	return self


func as_dictionary() -> Dictionary:
	var aux = super()
	aux[IMAGE] = image
	return aux
