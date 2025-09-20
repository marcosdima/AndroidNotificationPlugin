@tool
extends EditorPlugin

# A class member to hold the editor export plugin during its lifecycle.
var export_plugin : AndroidExportPlugin

func _enter_tree():
	# Initialization of the plugin goes here.
	export_plugin = AndroidExportPlugin.new()
	add_export_plugin(export_plugin)


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_export_plugin(export_plugin)
	export_plugin = null


class AndroidExportPlugin extends EditorExportPlugin:
	# TODO: Update to your plugin's name.
	var _plugin_name = "NotificationHandler"
	var _godot_plugin_name = "AndroidNotificationPlugin"

	func _supports_platform(platform):
		return platform is EditorExportPlatformAndroid
	
	
	func _get_android_libraries(_platform, _debug):
		return PackedStringArray([_godot_plugin_name + "/bin/" + _plugin_name + "-release.aar"])
	
	
	func _get_android_dependencies(_platform, _debug):
		# TODO: Add remote dependencies here.
		var deps = [
			'com.squareup.moshi:moshi:1.15.2',
			'com.squareup.moshi:moshi-kotlin:1.15.2',
			'com.squareup.moshi:moshi-adapters:1.15.2'
		]
		return PackedStringArray(deps)
	
	
	func _get_name():
		return _plugin_name
