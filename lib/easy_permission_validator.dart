library easy_permission_validator;

import 'dart:io' as io;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_popup.dart';

class EasyPermissionValidator {
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
  ///
  /// For ANDROID (android/app/src/main/AndroidManifest.xml):
  ///
  /// https://developer.android.com/guide/topics/permissions/overview
  ///
  /// LOCATION:
  ///
  /// <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  /// <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  ///
  /// CALENDAR:
  ///
  /// <uses-permission android:name="android.permission.READ_CALENDAR" />
  /// <uses-permission android:name="android.permission.WRITE_CALENDAR" />
  ///
  /// STORAGE:
  ///
  /// <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
  /// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  ///
  /// CAMERA:
  ///
  /// <uses-permission android:name="android.permission.CAMERA" />
  ///
  /// MICROPHONE:
  ///
  /// <uses-permission android:name="android.permission.MICROPHONE" />
  ///
  /// SENSORS:
  ///
  /// <uses-permission android:name="android.permission.SENSORS" />
  ///
  /// CONTACTS:
  ///
  /// <uses-permission android:name="android.permission.READ_CONTACTS" />
  /// <uses-permission android:name="android.permission.WRITE_CONTACTS" />
  /// <uses-permission android:name="android.permission.GET_ACCOUNTS" />
  ///
  /// PHONE:
  ///
  /// <uses-permission android:name="android.permission.READ_PHONE_STATE" />
  /// <uses-permission android:name="android.permission.READ_PHONE_NUMBERS" />
  /// <uses-permission android:name="android.permission.CALL_PHONE" />
  /// <uses-permission android:name="android.permission.ANSWER_PHONE_CALLS" />
  /// <uses-permission android:name="android.permission.ADD_VOICEMAIL" />
  /// <uses-permission android:name="android.permission.USE_SIP" />
  ///
  /// SMS:
  ///
  /// <uses-permission android:name="android.permission.SEND_SMS" />
  /// <uses-permission android:name="android.permission.RECEIVE_SMS" />
  /// <uses-permission android:name="android.permission.READ_SMS" />
  /// <uses-permission android:name="android.permission.RECEIVE_WAP_PUSH" />
  /// <uses-permission android:name="android.permission.RECEIVE_MMS" />
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

  Future<bool> contacts() async {
    return await _validatePermission(Permission.contacts);
  }

  Future<bool> calendar() async {
    return await _validatePermission(Permission.calendar);
  }

  Future<bool> camera() async {
    return await _validatePermission(Permission.camera);
  }

  Future<bool> phone() async {
    return await _validatePermission(Permission.phone);
  }

  Future<bool> reminders() async {
    return await _validatePermission(Permission.reminders);
  }

  Future<bool> sensors() async {
    return await _validatePermission(Permission.sensors);
  }

  Future<bool> storage() async {
    if (io.Platform.isAndroid) {
      return await _validatePermission(Permission.storage);
    }
    return true;
  }

  Future<bool> microphone() async {
    return await _validatePermission(Permission.microphone);
  }

  Future<bool> speech() async {
    return await _validatePermission(Permission.speech);
  }

  Future<bool> photos() async {
    return await _validatePermission(Permission.photos);
  }

  Future<bool> mediaLibrary() async {
    return await _validatePermission(Permission.mediaLibrary);
  }

  /// The best option for LOCATION request
  Future<bool> location() async {
    return await _validatePermission(Permission.location);
  }

  Future<bool> locationAlways() async {
    return await _validatePermission(Permission.locationAlways);
  }

  Future<bool> locationWhenInUse() async {
    return await _validatePermission(Permission.locationWhenInUse);
  }

  Future<bool> sms() async {
    if (io.Platform.isAndroid) {
      return await _validatePermission(Permission.sms);
    }
    return true;
  }

  Future<bool> _validatePermission(Permission permissionGroup) async {
    PermissionStatus status = await permissionGroup.request();

    switch (status) {
      case PermissionStatus.granted:
        return true;
        break;
      case PermissionStatus.permanentlyDenied:
        _showPermissionPopup(status: status);
        return false;
        break;
      case PermissionStatus.denied:
        return false;
        break;
      default:
        return false;
        break;
    }
  }

  _showPermissionPopup({PermissionStatus? status}) {
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
