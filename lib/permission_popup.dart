part of easy_permission_validator;

class PermissionPopup {
  PermissionPopup({
    required this.context,
    required this.appName,
    this.appNameColor,
    this.goToSettingsText,
    this.cancelText,
    this.enableLocationMessage,
    this.permissionSettingsMessage,
    this.customDialog,
  });

  BuildContext context;
  String appName;
  Color? appNameColor;
  String? goToSettingsText;
  String? cancelText;
  String? enableLocationMessage;
  String? permissionSettingsMessage;
  Widget? customDialog;

  Future<void> show({PermissionStatus? status}) async {
    await showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return customDialog != null
            ? customDialog!
            : _standardDialog(status: status);
      },
    );
  }

  Widget _standardDialog({PermissionStatus? status}) {
    return AlertDialog(
      title: Center(
        child: Text(
          appName,
          style: TextStyle(
            color: appNameColor ?? Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              _getMessage(status),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: _closePopup,
          child: Text(cancelText ?? 'Cancel'),
        ),
        ElevatedButton(
          onPressed: _openPermissionSettings,
          child: Text(goToSettingsText ?? 'Go to configuration'),
        ),
      ],
    );
  }

  String _getMessage(PermissionStatus? status) {
    if (status != null && status.isPermanentlyDenied) {
      return enableLocationMessage ??
          'You have to enable the required permissions to use the action.';
    }
    return permissionSettingsMessage ??
        'You need to enable required permissions for the app to work correctly';
  }

  Future<void> _openPermissionSettings() async {
    await openAppSettings();
    _closePopup();
  }

  void _closePopup() {
    Navigator.of(context).pop();
  }
}
