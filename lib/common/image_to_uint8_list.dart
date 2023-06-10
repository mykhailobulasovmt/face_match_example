import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<Uint8List?> imageToUint8List(Image image) async {
  final completer = Completer<ui.Image>();
  image.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, _) => completer.complete(info.image)),
      );
  final uiImage = await completer.future;
  final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
  return byteData?.buffer.asUint8List();
}
