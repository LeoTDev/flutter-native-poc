import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class HybridComposition extends StatelessWidget {
  const HybridComposition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Hybrid Composition"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(color: Colors.red, width:200, height:200, child: const Center(child: Text("Flutter View")),),
            Container(color: Colors.red, width:200, height:200, child: _nativeView(context)),
            Container(color: Colors.red, width:200, height:200, child: const Center(child: Text("Flutter View")),),
          ],
        ),
      ),
    );
  }

  Widget _nativeView(BuildContext context) {
    final theme = Theme.of(context);
    const String viewType = 'nativeView';
    Map<String, dynamic> creationParams = <String, dynamic>{
      "textColor": theme.primaryColorLight.value,
      "backgroundColor": theme.primaryColorDark.value
    };
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformViewLink(
          viewType: viewType,
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<
                  OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        return const Text("Not Implemented platform");
    }
  }
}
