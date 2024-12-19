import 'dart:async';

import 'package:flutter/material.dart';

class ImageScopeUtilities {
  // Preload image
  static Future<void> preloadImage(
      BuildContext context, String imageUrl) async {
    final Image image = Image.network(imageUrl);
    final Completer<void> completer = Completer<void>();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((_, __) {
        completer.complete();
      }),
    );
    await completer.future;
  }
}
