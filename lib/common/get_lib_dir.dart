import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef GetLib = void Function(String libDir);

Future<void> getLibDir({
  required MethodChannel platform,
  required GetLib callBack,
}) async {
  String libDir = "None";
  try {
    final String res = await platform.invokeMethod('getNativeLibDir');
    libDir = res;
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print('getLibDir error: $e');
    }
  }
  callBack(libDir);
}
