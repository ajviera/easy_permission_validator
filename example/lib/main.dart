import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Permission Validator Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title!)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.camera),
              iconSize: 90,
              onPressed: _permissionWithCustomPopup,
            ),
            IconButton(
              icon: const Icon(Icons.camera),
              iconSize: 90,
              onPressed: _permissionRequest,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                _result ?? '',
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _permissionRequest() async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Easy Permission Validator',
    );
    final result = await permissionValidator.camera();
    if (result) {
      setState(() => _result = 'Permission accepted');
    }
  }

  Future<void> _permissionWithCustomPopup() async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Easy Permission Validator',
      customDialog: _MyAmazingCustomPopup(),
    );
    final result = await permissionValidator.requestPermission(
      Permission.camera,
    );
    if (result) {
      setState(() => _result = 'Permission accepted');
    }
  }
}

class _MyAmazingCustomPopup extends StatefulWidget {
  @override
  State<_MyAmazingCustomPopup> createState() => _MyAmazingCustomPopupState();
}

class _MyAmazingCustomPopupState extends State<_MyAmazingCustomPopup> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Easy Permission Validator Demo',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.perm_camera_mic,
                      size: 60,
                      color: Colors.red,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: _closePopup,
                          icon: const Icon(Icons.cancel),
                          label: const Text('Cancel'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _openPermissionSettings,
                          icon: const Icon(Icons.arrow_forward_ios),
                          label: const Text('Go To Settings'),
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

  Future<void> _openPermissionSettings() async {
    await openAppSettings();
    _closePopup();
  }

  void _closePopup() {
    Navigator.of(context).pop();
  }
}
