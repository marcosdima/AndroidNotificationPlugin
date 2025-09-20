# AndroidNotificationPlugin

AndroidNotificationPlugin is a Godot plugin for managing and sending notifications on Android devices.

---

## Installation

1. Download the `.zip` file of this repository. (Or just clone the repository)
2. Extract it into your project under `res://addons/`.  
   The structure should look like this:

```text
res://
└── addons/
    └── AndroidNotificationPlugin/
        ├── plugin.cfg
        ├── export_plugin.gd
        └── ...
```

3. In Godot, go to **Project → Project Settings → Plugins** and activate **AndroidNotificationPlugin**.

---

## Setup

1. Add a `NotificationNode` to your scene.  
2. Configure notification images:
   - Load them as [CompressedTexture2D](https://docs.godotengine.org/en/stable/classes/class_compressedtexture2d.html).
   - Assign a resource name for each image.  
   - Recommendation: set an `small_icon.png` for simpler implementation.
3. Define channels:
   - At least one channel is required.  
   - Important: do not repeat channel IDs.
4. Permission:
   On devices running Android 13 (API 33) or higher, the POST_NOTIFICATIONS permission is required in order to display notifications. Call ```NotificationNode.request_post_notification()``` to request this permission from the user at runtime. 

---

## Usage

After setup, the plugin will be ready to use.  
Examples of usage can be found in the `main.gd` file provided in the repository.


## Future implementations
- Persistent scheduled notifications: ensure that scheduled notifications remain active even after the app is closed or restarted.
- Extended customization options: provide more ways to customize notifications.

---

## License

This project is licensed under the MIT License.
