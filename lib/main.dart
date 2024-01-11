import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:native_poc/event_channel_demo.dart';
import 'package:native_poc/hybrid_composition_gestures.dart';
import 'package:native_poc/virtual_display_gestures.dart';

import 'hybrid_composition.dart';
import 'method_channel_demo.dart';
import 'reverse_method_channel_demo.dart';
import 'virtual_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Menu(),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => _navigate(context, const MethodChannelDemo()),
                child: const Text(
                  "Method Channel",
                )),
            ElevatedButton(
                onPressed: () => _navigate(context, const ReverseMethodChannelDemo()),
                child: const Text(
                  "Reverse Method Channel",
                )),
            ElevatedButton(
                onPressed: () => _navigate(context, const EventChannelDemo()),
                child: const Text(
                  "Event Channel",
                )),
            ElevatedButton(
                onPressed: () => _navigate(context, const HybridComposition()),
                child: const Text("Hybrid Composition")),
            ElevatedButton(
                onPressed: defaultTargetPlatform == TargetPlatform.android
                    ? () => _navigate(context, const VirtualDisplay())
                    : null,
                child: const Text("Virtual Display")),
            ElevatedButton(
                onPressed: () => _navigate(context, const HybridCompositionGestures()),
                child: const Text("Hybrid Composition - Gestures")),
            ElevatedButton(
                onPressed: defaultTargetPlatform == TargetPlatform.android
                    ? () => _navigate(context, const VirtualDisplayGestures())
                    : null,
                child: const Text("Virtual Display - Gestures")),
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => widget),
    );
  }
}
