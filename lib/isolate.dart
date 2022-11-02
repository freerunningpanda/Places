import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:places/ui/screens/splash_screen/splash_screen.dart';

late ReceivePort _receivePort;
late Isolate _isolate;

void startIsolateLoop() async {
  _receivePort = ReceivePort();
  _isolate = await Isolate.spawn(isolateLoop, _receivePort.sendPort);
  _receivePort.listen((dynamic message) {
    debugPrint(message.toString());
  });
}
