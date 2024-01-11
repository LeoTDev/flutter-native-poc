import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReverseMethodChannelDemo extends StatefulWidget {
  const ReverseMethodChannelDemo({super.key});

  @override
  State<ReverseMethodChannelDemo> createState() => _ReverseMethodChannelDemoState();
}

class _ReverseMethodChannelDemoState extends State<ReverseMethodChannelDemo> {
  static const methodChannel = MethodChannel('com.test.library/nativeMethods');
  int _number = 0;


  @override
  void initState() {
    super.initState();
    methodChannel.setMethodCallHandler(methodHandler);
  }

  void start() {
    methodChannel.invokeMethod('startReverseInvocation');
  }

  Future<void> methodHandler(MethodCall call) async {
    switch (call.method) {
      case "updateState":
        final int newNumber = call.arguments;
        setState(() {
          _number = newNumber;
        });
        break;
      default:
        print('no method handler for method ${call.method}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Method Invocation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                child: const Text("reverse invoke"),
                onPressed: () {
                  start();
                }),
            Text(
              '$_number',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}