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
  /// - For iOS (ios/Runner/Info.plist):
  /// - For ANDROID (android/app/src/main/AndroidManifest.xml):
  /// https://developer.android.com/guide/topics/permissions/overview
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

  Future<bool> requestPermission(Permission permission) async {
    return _validatePermission(permission);
  }

  /// For this Storage permission request we recommend the use of
  /// the following method
  Future<bool> storage() async {
    if (io.Platform.isAndroid) {
      return _validatePermission(Permission.storage);
    }
    return true;
  }

  /// For this SMS permission request we recommend the use of
  /// the following method
  Future<bool> sms() async {
    if (io.Platform.isAndroid) {
      return _validatePermission(Permission.sms);
    }
    return true;
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

  // Quick access to some specific permissions requests
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
}
