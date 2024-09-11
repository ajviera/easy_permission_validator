# Easy Permission Validator

This package is useful when you need to manage on-demand permissions for both Android and iOS.

[![pub package](https://img.shields.io/pub/v/easy_permission_validator.svg?style=plastic)](https://pub.dartlang.org/packages/easy_permission_validator)

## Usage

To use this plugin, add `easy_permission_validator` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

Base use:

```dart
_permissionRequest() async {
  final permissionValidator = EasyPermissionValidator(
    context: context,
    appName: 'Easy Permission Validator',
  );
  var result = await permissionValidator.camera();
  if (result) {
    // Do something;
  }
}
```

You can add custom messages for other languages:

```dart
_permissionRequest() async {
  final permissionValidator = EasyPermissionValidator(
    context: context,
    appName: 'Easy Permission Validator',
    appNameColor: Colors.red,
    cancelText: 'Cancelar',
    enableLocationMessage:
        'Debe habilitar los permisos necesarios para utilizar la acción.',
    goToSettingsText: 'Ir a Configuraciones',
    permissionSettingsMessage:
        'Necesita habilitar los permisos necesarios para que la aplicación funcione correctamente',
  );
  var result = await permissionValidator.camera();
  if (result) {
    // Do something;
  }
}
```

In addition, you can add a custom Dialog:

```dart
_permissionWithCustomPopup() async {
  final permissionValidator = EasyPermissionValidator(
    context: context,
    appName: 'Easy Permission Validator',
    customDialog: MyAmazingCustomPopup(),
  );
  var result = await permissionValidator.camera();
  if (result) {
    // Do something;
  }
}
```

## Caution

Some permissions must be in the privacy policy

## Permissions

If you use any permissions from this package, you must add:

For iOS (add in `ios/Runner/Info.plist`):

```txt
  <!-- Permission options for the `location` group -->
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>Need location when in use</string>
  <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
  <string>Always and when in use!</string>
  <key>NSLocationUsageDescription</key>
  <string>Older devices need location.</string>
  <key>NSLocationAlwaysUsageDescription</key>
  <string>Can I have location always?</string>

  <!-- Permission options for the `mediaLibrary` group -->
  <key>NSAppleMusicUsageDescription</key>
  <string>Music!</string>
  <key>kTCCServiceMediaLibrary</key>
  <string>media</string>

  <!-- Permission options for the `calendar` group -->
  <key>NSCalendarsUsageDescription</key>
  <string>Calendars</string>
  <key>NSCalendarsFullAccessUsageDescription</key>
  <string>Calendar full access</string>

  <!-- Permission options for the `camera` group -->
  <key>NSCameraUsageDescription</key>
  <string>camera</string>

  <!-- Permission options for the `contacts` group -->
  <key>NSContactsUsageDescription</key>
  <string>contacts</string>

  <!-- Permission options for the `microphone` group -->
  <key>NSMicrophoneUsageDescription</key>
  <string>microphone</string>

  <!-- Permission options for the `speech` group -->
  <key>NSSpeechRecognitionUsageDescription</key>
  <string>speech</string>

  <!-- Permission options for the `sensors` group -->
  <key>NSMotionUsageDescription</key>
  <string>motion</string>

  <!-- Permission options for the `photos` group -->
  <key>NSPhotoLibraryUsageDescription</key>
  <string>photos</string>

  <!-- Permission options for the `reminder` group -->
  <key>NSRemindersUsageDescription</key>
  <string>reminders</string>

  <!-- Permission options for the `bluetooth` -->
  <key>NSBluetoothAlwaysUsageDescription</key>
  <string>bluetooth</string>
  <key>NSBluetoothPeripheralUsageDescription</key>
  <string>bluetooth</string>

  <!-- Permission options for the `appTrackingTransparency` -->
  <key>NSUserTrackingUsageDescription</key>
  <string>appTrackingTransparency</string>

  <!-- Permission options for the `assistant` group -->
  <key>NSSiriUsageDescription</key>
  <string>The example app would like access to Siri Kit to demonstrate requesting authorization.</string>
```

For ANDROID (add in `android/app/src/main/AndroidManifest.xml`):

[Permissions on Android](https://developer.android.com/guide/topics/permissions/overview)

```txt
  <!--
  Internet permissions do not affect the `permission_handler` plugin, but are required if your app needs access to
  the internet.
  -->
  <uses-permission android:name="android.permission.INTERNET"/>

  <!-- Permissions options for the `contacts` group -->
  <uses-permission android:name="android.permission.READ_CONTACTS"/>
  <uses-permission android:name="android.permission.WRITE_CONTACTS"/>
  <uses-permission android:name="android.permission.GET_ACCOUNTS"/>

  <!-- Permissions options for the `storage` group -->
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
  <!-- Read storage permission for Android 12 and lower -->
  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
  <!--
    Granular media permissions for Android 13 and newer.
    See https://developer.android.com/about/versions/13/behavior-changes-13#granular-media-permissions
    for more information.
  -->
  <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
  <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
  <uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />

  <!-- Permissions options for the `camera` group -->
  <uses-permission android:name="android.permission.CAMERA"/>

  <!-- Permissions options for the `sms` group -->
  <uses-permission android:name="android.permission.SEND_SMS"/>
  <uses-permission android:name="android.permission.RECEIVE_SMS"/>
  <uses-permission android:name="android.permission.READ_SMS"/>
  <uses-permission android:name="android.permission.RECEIVE_WAP_PUSH"/>
  <uses-permission android:name="android.permission.RECEIVE_MMS"/>

  <!-- Permissions options for the `phone` group -->
  <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
  <uses-permission android:name="android.permission.CALL_PHONE"/>
  <uses-permission android:name="android.permission.ADD_VOICEMAIL"/>
  <uses-permission android:name="android.permission.USE_SIP"/>
  <uses-permission android:name="android.permission.READ_CALL_LOG"/>
  <uses-permission android:name="android.permission.WRITE_CALL_LOG"/>
  <uses-permission android:name="android.permission.BIND_CALL_REDIRECTION_SERVICE"/>

  <!-- Permissions options for the `calendar` group -->
  <uses-permission android:name="android.permission.READ_CALENDAR" />
  <uses-permission android:name="android.permission.WRITE_CALENDAR" />

  <!-- Permissions options for the `location` group -->
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

  <!-- Permissions options for the `microphone` or `speech` group -->
  <uses-permission android:name="android.permission.RECORD_AUDIO" />

  <!-- Permissions options for the `sensors` group -->
  <uses-permission android:name="android.permission.BODY_SENSORS" />
  <uses-permission android:name="android.permission.BODY_SENSORS_BACKGROUND" />

  <!-- Permissions options for the `accessMediaLocation` group -->
  <uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />

  <!-- Permissions options for the `activityRecognition` group -->
  <uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />

  <!-- Permissions options for the `ignoreBatteryOptimizations` group -->
  <uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />

  <!-- Permissions options for the `nearby devices` group -->
  <uses-permission android:name="android.permission.BLUETOOTH" />
  <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
  <uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />
  <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
  <uses-permission android:name="android.permission.NEARBY_WIFI_DEVICES" />

  <!-- Permissions options for the `manage external storage` group -->
  <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />

  <!-- Permissions options for the `system alert windows` group -->
  <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />

  <!-- Permissions options for the `request install packages` group -->
  <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />

  <!-- Permissions options for the `access notification policy` group -->
  <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY"/>

  <!-- Permissions options for the `notification` group -->
  <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>

  <!-- Permissions options for the `alarm` group -->
  <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
```

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/ajviera/easy_permission_validator/issues) page.

## Contributions

You can contribute by making a pull request, this package was made for the community and you have complete power to add whatever they find useful.
