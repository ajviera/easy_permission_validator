library easy_permission_validator;

import 'dart:async';

import 'package:easy_permission_validator/permisson_popup.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io' as io;

class PermissionValidator {
  PermissionHandler permissionHandler = PermissionHandler();

  /// App title to show in the standard popup
  String appName;

  /// You can change the standard popup if you need
  Widget customDialog;

  BuildContext context;

  /// App title Color to show in the standard popup
  Color appNameColor;

  /// Optional in case you need to use other languages
  String goToSettingsText;

  /// Optional in case you need to use other languages
  String cancelText;

  /// Optional in case you need to use other languages
  String enableLocationMessage;

  /// Optional in case you need to use other languages
  String permissionSettingsMessage;

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
  PermissionValidator({
    @required this.context,
    @required this.appName,
    customDialog,
    appNameColor,
    cancelText,
    enableLocationMessage,
    goToSettingsText,
    permissionSettingsMessage,
  });

  Future<bool> contacts() async {
    return await _validatePermission(PermissionGroup.contacts);
  }

  Future<bool> calendar() async {
    return await _validatePermission(PermissionGroup.calendar);
  }

  Future<bool> camera() async {
    return await _validatePermission(PermissionGroup.camera);
  }

  Future<bool> phone() async {
    return await _validatePermission(PermissionGroup.phone);
  }

  Future<bool> reminders() async {
    return await _validatePermission(PermissionGroup.reminders);
  }

  Future<bool> sensors() async {
    return await _validatePermission(PermissionGroup.sensors);
  }

  Future<bool> storage() async {
    return await _validatePermission(PermissionGroup.storage);
  }

  Future<bool> microphone() async {
    return await _validatePermission(PermissionGroup.microphone);
  }

  Future<bool> speech() async {
    return await _validatePermission(PermissionGroup.speech);
  }

  Future<bool> photos() async {
    return await _validatePermission(PermissionGroup.photos);
  }

  Future<bool> mediaLibrary() async {
    return await _validatePermission(PermissionGroup.mediaLibrary);
  }

  /// The best option for LOCATION request
  Future<bool> location() async {
    return await _validatePermission(PermissionGroup.location);
  }

  Future<bool> locationAlways() async {
    return await _validatePermission(PermissionGroup.locationAlways);
  }

  Future<bool> locationWhenInUse() async {
    return await _validatePermission(PermissionGroup.locationWhenInUse);
  }

  Future<bool> sms() async {
    if (io.Platform.isAndroid) {
      return await _validatePermission(PermissionGroup.sms);
    }
    return true;
  }

  Future<bool> _validatePermission(PermissionGroup permissionGroup) async {
    PermissionStatus permission =
        await permissionHandler.checkPermissionStatus(permissionGroup);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> state =
          await permissionHandler.requestPermissions([permissionGroup]);
      if (state[permissionGroup] == PermissionStatus.granted) {
        return true;
      } else {
        _showPermissionPopup(status: state);
      }
    }
    if (permission == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  _showPermissionPopup({Map<PermissionGroup, PermissionStatus> status}) {
    PermissionPopup(
      appNameColor: this.appNameColor,
      cancelText: this.cancelText,
      enableLocationMessage: this.enableLocationMessage,
      goToSettingsText: this.goToSettingsText,
      permissionSettingsMessage: this.permissionSettingsMessage,
      context: context,
      appName: this.appName,
      customDialog: this.customDialog,
    ).show(status: status);
  }
}
