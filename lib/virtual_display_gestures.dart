import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VirtualDisplayGestures extends StatelessWidget {
  const VirtualDisplayGestures({super.key});

  @override
  Widget build(BuildContext context) {
    const String viewType = 'nativeViewGestures';
    Map<String, dynamic> creationParams = <String, dynamic>{};

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Virtual Display Gestures"),
        ),
        body: AndroidView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        )
    );
  }
}
