library easy_permission_validator;

import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_popup.dart';

class EasyPermissionValidator {
  /// Caution: Some permissions must be in the privacy policy
  ///
  /// If you use any permissions from this package, you must add:
  ///
  /// For iOS (ios/Runner/Info.plist):
  ///
  /// CALENDAR:
  ///
  /// <key>NSCalendarsUsageDescription</key>
  /// <string>This app requires calendars access to function properly.</string>
  ///
  /// CAMERA:
  ///
  /// <key>NSCameraUsageDescription</key>
  /// <string>App requires access to the camera.</string>
  ///
  /// CONTACTS:
  ///
  /// <key>NSContactsUsageDescription</key>
  /// <string>This app requires contacts access to function properly.</string>
  ///
  /// LOCATION:
  ///
  /// <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
  /// <string>This app requires location access to function properly.</string>
  /// <key>NSLocationAlwaysUsageDescription</key>
  /// <string>This app requires location access to function properly.</string>
  /// <key>NSLocationUsageDescription</key>
  /// <string>This app requires location access to function properly.</string>
  /// <key>NSLocationWhenInUseUsageDescription</key>
  /// <string>This app requires location access to function properly.</string>
  ///
  /// MICROPHONE:
  ///
  /// <key>NSMicrophoneUsageDescription</key>
  /// <string>This app requires mic access to record video.</string>
  ///
  /// PHOTOS:
  ///
  /// <key>NSPhotoLibraryUsageDescription</key>
  /// <string>This app requires photo library access to function properly.</string>
  ///
  /// SENSORS:
  ///
  /// <key>NSMotionUsageDescription</key>
  /// <string>This app requires motion access</string>
  ///
  /// REMINDER:
  ///
  ///<key>NSRemindersUsageDescription</key>
  /// <string>This app requires reminders access to function properly.</string>
  ///
  /// MICROPHONE:
  ///
  /// <key>NSSpeechRecognitionUsageDescription</key>
  /// <string>This app requires mic access to record video.</string>
  ///
  /// BLUETOOTH:
  ///
  /// <key>NSBluetoothAlwaysUsageDescription</key>
  /// <string>Description here.</string>
  /// <key>NSBluetoothPeripheralUsageDescription</key>
  /// <string>Description here.</string>
  ///
  /// MEDIA LIBRARY:
  ///
  /// <key>NSAppleMusicUsageDescription</key>
  /// <string>Description here.</string>
  /// <key>kTCCServiceMediaLibrary</key>
  /// <string>Description here.</string>
  ///
  /// APP TRACKING TRANSPARENCY:
  ///
  /// <key>NSUserTrackingUsageDescription</key>
  /// <string>Description here.</string>
  ///
  ///
  /// For ANDROID (android/app/src/main/AndroidManifest.xml):
  ///
  /// https://developer.android.com/guide/topics/permissions/overview
  ///
  /// Internet permissions do not affect the `permission_handler` plugin, but
  /// are required if your app needs access to the internet.
  ///
  /// <uses-permission android:name="android.permission.INTERNET"/>
  ///
  /// Permissions options for the `contacts` group
  /// <uses-permission android:name="android.permission.READ_CONTACTS"/>
  /// <uses-permission android:name="android.permission.WRITE_CONTACTS"/>
  /// <uses-permission android:name="android.permission.GET_ACCOUNTS"/>
  ///
  /// Permissions options for the `storage` group
  /// <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
  /// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
  ///
  /// Permissions options for the `camera` group
  /// <uses-permission android:name="android.permission.CAMERA"/>
  ///
  /// Permissions options for the `sms` group
  /// <uses-permission android:name="android.permission.SEND_SMS"/>
  /// <uses-permission android:name="android.permission.RECEIVE_SMS"/>
  /// <uses-permission android:name="android.permission.READ_SMS"/>
  /// <uses-permission android:name="android.permission.RECEIVE_WAP_PUSH"/>
  /// <uses-permission android:name="android.permission.RECEIVE_MMS"/>
  ///
  /// Permissions options for the `phone` group
  /// <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
  /// <uses-permission android:name="android.permission.CALL_PHONE"/>
  /// <uses-permission android:name="android.permission.ADD_VOICEMAIL"/>
  /// <uses-permission android:name="android.permission.USE_SIP"/>
  /// <uses-permission android:name="android.permission.READ_CALL_LOG"/>
  /// <uses-permission android:name="android.permission.WRITE_CALL_LOG"/>
  /// <uses-permission android:name="android.permission.BIND_CALL_REDIRECTION_SERVICE"/>
  ///
  /// Permissions options for the `calendar` group
  /// <uses-permission android:name="android.permission.READ_CALENDAR" />
  /// <uses-permission android:name="android.permission.WRITE_CALENDAR" />
  ///
  /// Permissions options for the `location` group
  /// <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  /// <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  /// <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
  ///
  /// Permissions options for the `microphone` or `speech` group
  /// <uses-permission android:name="android.permission.RECORD_AUDIO" />
  ///
  /// Permissions options for the `sensors` group
  /// <uses-permission android:name="android.permission.BODY_SENSORS" />
  ///
  /// Permissions options for the `accessMediaLocation` group
  /// <uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />
  ///
  /// Permissions options for the `activityRecognition` group
  /// <uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />
  ///
  /// Permissions options for the `ignoreBatteryOptimizations` group
  /// <uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />
  ///
  /// Permissions options for the `bluetooth` group
  /// <uses-permission android:name="android.permission.BLUETOOTH" />
  /// <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
  /// <uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />
  /// <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
  ///
  /// Permissions options for the `manage external storage` group
  /// <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
  ///
  /// Permissions options for the `system alert windows` group
  /// <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
  ///
  /// Permissions options for the `request install packages` group
  /// <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
  ///
  /// Permissions options for the `access notification policy` group
  /// <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY"/>
  ///
  ///
  EasyPermissionValidator({
    required this.context,
    required this.appName,
    this.customDialog,
    this.appNameColor,
    this.cancelText,
    this.enableLocationMessage,
    this.goToSettingsText,
    this.permissionSettingsMessage,
  });

  /// App title to show in the standard popup
  String appName;

  /// You can change the standard popup if you need
  Widget? customDialog;

  BuildContext context;

  /// App title Color to show in the standard popup
  Color? appNameColor;

  /// Optional in case you need to use other languages
  String? goToSettingsText;

  /// Optional in case you need to use other languages
  String? cancelText;

  /// Optional in case you need to use other languages
  String? enableLocationMessage;

  /// Optional in case you need to use other languages
  String? permissionSettingsMessage;

  Future<bool> contacts() async {
    return _validatePermission(Permission.contacts);
  }

  Future<bool> calendarFullAccess() async {
    return _validatePermission(Permission.calendarFullAccess);
  }

  Future<bool> calendarWriteOnly() async {
    return _validatePermission(Permission.calendarWriteOnly);
  }

  Future<bool> camera() async {
    return _validatePermission(Permission.camera);
  }

  Future<bool> phone() async {
    return _validatePermission(Permission.phone);
  }

  Future<bool> reminders() async {
    return _validatePermission(Permission.reminders);
  }

  Future<bool> sensors() async {
    return _validatePermission(Permission.sensors);
  }

  Future<bool> storage() async {
    if (io.Platform.isAndroid) {
      return _validatePermission(Permission.storage);
    }
    return true;
  }

  Future<bool> microphone() async {
    return _validatePermission(Permission.microphone);
  }

  Future<bool> speech() async {
    return _validatePermission(Permission.speech);
  }

  Future<bool> photos() async {
    return _validatePermission(Permission.photos);
  }

  Future<bool> mediaLibrary() async {
    return _validatePermission(Permission.mediaLibrary);
  }

  /// The best option for LOCATION request
  Future<bool> location() async {
    return _validatePermission(Permission.location);
  }

  Future<bool> locationAlways() async {
    return _validatePermission(Permission.locationAlways);
  }

  Future<bool> locationWhenInUse() async {
    return _validatePermission(Permission.locationWhenInUse);
  }

  Future<bool> sms() async {
    if (io.Platform.isAndroid) {
      return _validatePermission(Permission.sms);
    }
    return true;
  }

  Future<bool> bluetooth() async {
    return _validatePermission(Permission.bluetooth);
  }

  Future<bool> bluetoothScan() async {
    return _validatePermission(Permission.bluetoothScan);
  }

  Future<bool> bluetoothAdvertise() async {
    return _validatePermission(Permission.bluetoothAdvertise);
  }

  Future<bool> bluetoothConnect() async {
    return _validatePermission(Permission.bluetoothConnect);
  }

  Future<bool> appTrackingTransparency() async {
    return _validatePermission(Permission.appTrackingTransparency);
  }

  Future<bool> criticalAlerts() async {
    return _validatePermission(Permission.criticalAlerts);
  }

  Future<bool> notification() async {
    return _validatePermission(Permission.notification);
  }

  Future<bool> accessNotificationPolicy() async {
    return _validatePermission(Permission.accessNotificationPolicy);
  }

  Future<bool> requestInstallPackages() async {
    return _validatePermission(Permission.requestInstallPackages);
  }

  Future<bool> systemAlertWindow() async {
    return _validatePermission(Permission.systemAlertWindow);
  }

  Future<bool> manageExternalStorage() async {
    return _validatePermission(Permission.manageExternalStorage);
  }

  Future<bool> ignoreBatteryOptimizations() async {
    return _validatePermission(Permission.ignoreBatteryOptimizations);
  }

  Future<bool> activityRecognition() async {
    return _validatePermission(Permission.activityRecognition);
  }

  Future<bool> _validatePermission(Permission permissionGroup) async {
    final status = await permissionGroup.request();

    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
      case PermissionStatus.provisional:
        return true;
      case PermissionStatus.denied:
        return false;
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        _showPermissionPopup(status: status);
        return false;
    }
  }

  void _showPermissionPopup({PermissionStatus? status}) {
    PermissionPopup(
      appNameColor: appNameColor,
      cancelText: cancelText,
      enableLocationMessage: enableLocationMessage,
      goToSettingsText: goToSettingsText,
      permissionSettingsMessage: permissionSettingsMessage,
      context: context,
      appName: appName,
      customDialog: customDialog,
    ).show(status: status);
  }
}
