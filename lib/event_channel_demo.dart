import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventChannelDemo extends StatefulWidget {
  const EventChannelDemo({super.key});

  @override
  State<EventChannelDemo> createState() => _EventChannelDemoState();
}

class _EventChannelDemoState extends State<EventChannelDemo> {

  final eventChannel = const EventChannel('timeHandlerEvent');

  Stream<String> streamTimeFromNative() {
    return eventChannel
        .receiveBroadcastStream()
        .map((event) => event.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: const Text("Event Channel Demo"),
    ),
    body: Center(
      child: StreamBuilder<String>(
        stream: streamTimeFromNative(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              '${snapshot.data}',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ),
    );
  }
}