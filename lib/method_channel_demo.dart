import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelDemo extends StatefulWidget {
  const MethodChannelDemo({super.key});

  @override
  State<MethodChannelDemo> createState() => _MethodChannelInvocationPageState();
}

class _MethodChannelInvocationPageState extends State<MethodChannelDemo> {
  static const platform = MethodChannel('com.test.library/nativeMethods');
  int _number = 0;

  Future<void> invokeNativeMethod() async {
    try {
      
      await platform.invokeMethod('randomNumber', [10]).then((value) {
        setState(() {
          _number = value;
        });
      });
    } on PlatformException catch (e) {
      print("error: $e");
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
                child: const Text("invoke"),
                onPressed: () {
                  invokeNativeMethod();
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
