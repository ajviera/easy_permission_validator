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
CALENDAR:
<key>NSCalendarsUsageDescription</key>
<string>This app requires calendars access to function properly.</string>

CAMERA:
<key>NSCameraUsageDescription</key>
<string>App requires access to the camera.</string>

CONTACTS:
<key>NSContactsUsageDescription</key>
<string>This app requires contacts access to function properly.</string>

LOCATION:
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app requires location access to function properly.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app requires location access to function properly.</string>
<key>NSLocationUsageDescription</key>
<string>This app requires location access to function properly.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app requires location access to function properly.</string>

MICROPHONE:
<key>NSMicrophoneUsageDescription</key>
<string>This app requires mic access to record video.</string>

PHOTOS:
<key>NSPhotoLibraryUsageDescription</key>
<string>This app requires photo library access to function properly.</string>

SENSORS:
<key>NSMotionUsageDescription</key>
<string>This app requires motion access</string>

REMINDER:
<key>NSRemindersUsageDescription</key>
<string>This app requires reminders access to function properly.</string>

MICROPHONE:
<key>NSSpeechRecognitionUsageDescription</key>
<string>This app requires mic access to record video.</string>

BLUETOOTH:
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Description here.</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>Description here.</string>

MEDIA LIBRARY:
<key>NSAppleMusicUsageDescription</key>
<string>Description here.</string>
<key>kTCCServiceMediaLibrary</key>
<string>Description here.</string>

APP TRACKING TRANSPARENCY:
<key>NSUserTrackingUsageDescription</key>
<string>Description here.</string>
```

For ANDROID (add in `android/app/src/main/AndroidManifest.xml`):

[Permissions on Android](https://developer.android.com/guide/topics/permissions/overview)

```txt
Permissions options for the `contacts` group
<uses-permission android:name="android.permission.READ_CONTACTS"/>
<uses-permission android:name="android.permission.WRITE_CONTACTS"/>
<uses-permission android:name="android.permission.GET_ACCOUNTS"/>

Permissions options for the `storage` group
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

Permissions options for the `camera` group
<uses-permission android:name="android.permission.CAMERA"/>

Permissions options for the `sms` group
<uses-permission android:name="android.permission.SEND_SMS"/>
<uses-permission android:name="android.permission.RECEIVE_SMS"/>
<uses-permission android:name="android.permission.READ_SMS"/>
<uses-permission android:name="android.permission.RECEIVE_WAP_PUSH"/>
<uses-permission android:name="android.permission.RECEIVE_MMS"/>

Permissions options for the `phone` group
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.CALL_PHONE"/>
<uses-permission android:name="android.permission.ADD_VOICEMAIL"/>
<uses-permission android:name="android.permission.USE_SIP"/>
<uses-permission android:name="android.permission.READ_CALL_LOG"/>
<uses-permission android:name="android.permission.WRITE_CALL_LOG"/>
<uses-permission android:name="android.permission.BIND_CALL_REDIRECTION_SERVICE"/>

Permissions options for the `calendar` group
<uses-permission android:name="android.permission.READ_CALENDAR" />
<uses-permission android:name="android.permission.WRITE_CALENDAR" />

Permissions options for the `location` group
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

Permissions options for the `microphone` or `speech` group
<uses-permission android:name="android.permission.RECORD_AUDIO" />

Permissions options for the `sensors` group
<uses-permission android:name="android.permission.BODY_SENSORS" />

Permissions options for the `accessMediaLocation` group
<uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />

Permissions options for the `activityRecognition` group
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />

Permissions options for the `ignoreBatteryOptimizations` group
<uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />

Permissions options for the `bluetooth` group
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />

Permissions options for the `manage external storage` group
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />

Permissions options for the `system alert windows` group
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />

Permissions options for the `request install packages` group
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />

Permissions options for the `access notification policy` group
<uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY"/>
```

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/ajviera/easy_permission_validator/issues) page.

## Contributions

You can contribute by making a pull request, this package was made for the community and you have complete power to add whatever they find useful.
