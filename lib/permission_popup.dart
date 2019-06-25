import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPopup {
  BuildContext context;
  String appName;
  Color appNameColor;
  String goToSettingsText;
  String cancelText;
  String enableLocationMessage;
  String permissionSettingsMessage;
  Widget customDialog;

  PermissionPopup({
    @required this.context,
    @required this.appName,
    this.appNameColor,
    this.goToSettingsText,
    this.cancelText,
    this.enableLocationMessage,
    this.permissionSettingsMessage,
    this.customDialog,
  });

  show({Map<PermissionGroup, PermissionStatus> status}) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return customDialog != null
            ? customDialog
            : AlertDialog(
                title: Center(
                  child: Text(
                    this.appName,
                    style: TextStyle(
                      color: this.appNameColor ?? Colors.black,
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _getMessage(status),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                        ),
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(this.cancelText ?? 'Cancel'),
                    onPressed: () => _closePopup(),
                  ),
                  FlatButton(
                    child: Text(this.goToSettingsText ?? 'Go to configuration'),
                    onPressed: () => _openPermissionSettings(),
                  )
                ],
              );
      },
    );
  }

  String _getMessage(Map<PermissionGroup, PermissionStatus> status) {
    if (status != null &&
        status[PermissionGroup.location] != null &&
        status[PermissionGroup.location] == PermissionStatus.disabled)
      return this.enableLocationMessage ??
          'You have to enable the required permissions to use the action.';
    return this.permissionSettingsMessage ??
        'You need to enable required permissions for the app to work correctly';
  }

  _openPermissionSettings() async {
    await PermissionHandler().openAppSettings();
    _closePopup();
  }

  _closePopup() {
    Navigator.of(context).pop();
  }
}
