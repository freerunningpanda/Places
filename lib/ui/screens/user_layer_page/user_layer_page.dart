import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class UserLayerExample extends StatefulWidget {
  
  const UserLayerExample({Key? key}) : super(key: key);

  @override
  _UserLayerExampleState createState() => _UserLayerExampleState();
}

class _UserLayerExampleState extends State<UserLayerExample> {
  late YandexMapController controller;
  GlobalKey mapKey = GlobalKey();

  Future<bool> get locationPermissionNotGranted async => !(await Permission.location.request().isGranted);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: YandexMap(
            key: mapKey,
            onMapCreated: (yandexMapController) async {
              controller = yandexMapController;
            },
            onUserLocationAdded: (view) async {
              return view.copyWith(
                pin: view.pin.copyWith(
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('lib/assets/user.png')),
                  ),
                ),
                arrow: view.arrow.copyWith(
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('lib/assets/arrow.png')),
                  ),
                ),
                accuracyCircle: view.accuracyCircle.copyWith(
                  fillColor: Colors.green.withOpacity(0.5),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ControlButton(
                        onPressed: () async {
                          if (await locationPermissionNotGranted) {
                            // ignore: use_build_context_synchronously
                            _showMessage(context, const Text('Location permission was NOT granted'));

                            return;
                          }

                          // ignore: use_build_context_synchronously
                          final mediaQuery = MediaQuery.of(context);
                          final height = mapKey.currentContext!.size!.height * mediaQuery.devicePixelRatio;
                          final width = mapKey.currentContext!.size!.width * mediaQuery.devicePixelRatio;

                          await controller.toggleUserLayer(
                              visible: true,
                              autoZoomEnabled: true,
                              anchor: UserLocationAnchor(
                                  course: Offset(width * 0.5, height * 0.5),
                                  normal: Offset(width * 0.5, height * 0.5),),);
                        },
                        title: 'Show user layer',),
                    ControlButton(
                        onPressed: () async {
                          if (await locationPermissionNotGranted) {
                            // ignore: use_build_context_synchronously
                            _showMessage(context, const Text('Location permission was NOT granted'));
                            
                            return;
                          }

                          await controller.toggleUserLayer(visible: false);
                        },
                        title: 'Hide user layer',),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ControlButton(
                        onPressed: () async {
                          if (await locationPermissionNotGranted) {
                            // ignore: use_build_context_synchronously
                            _showMessage(context, const Text('Location permission was NOT granted'));

                            return;
                          }

                          if (kDebugMode) {
                            print(await controller.getUserCameraPosition());
                          }
                        },
                        title: 'Get user camera position',),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showMessage(BuildContext context, Text text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: text));
  }
}

class ControlButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const ControlButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title, textAlign: TextAlign.center),
      ),
    );
  }
}
