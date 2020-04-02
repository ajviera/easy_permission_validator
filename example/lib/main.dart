import 'package:flutter/material.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Permission Validator Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.camera),
              iconSize: 90.0,
              onPressed: () => _permissionWithCustomPopup(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                _result,
                style: TextStyle(fontSize: 22.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _permissionRequest() async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Easy Permission Validator',
    );
    var result = await permissionValidator.camera();
    if (result) {
      setState(() => _result = 'Permission accepted');
    }
  }

  _permissionWithCustomPopup() async {
    EasyPermissionValidator permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Easy Permission Validator',
      customDialog: MyAmazingCustomPopup(),
    );
    var result = await permissionValidator.camera();
    if (result) {
      setState(() => _result = 'Permission accepted');
    }
  }
}

class MyAmazingCustomPopup extends StatefulWidget {
  @override
  _MyAmazingCustomPopupState createState() => _MyAmazingCustomPopupState();
}

class _MyAmazingCustomPopupState extends State<MyAmazingCustomPopup> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: SizedBox(
            height: 300.0,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Easy Permission Validator Demo',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.perm_camera_mic,
                      size: 60.0,
                      color: Colors.red,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton.icon(
                          icon: Icon(Icons.cancel),
                          onPressed: () => _closePopup(),
                          label: Text('Cancel'),
                        ),
                        FlatButton.icon(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () => _openPermissionSettings(),
                          label: Text('Go To Settings'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _openPermissionSettings() async {
    await openAppSettings();
    _closePopup();
  }

  _closePopup() {
    Navigator.of(context).pop();
  }
}
