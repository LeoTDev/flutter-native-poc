import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VirtualDisplay extends StatelessWidget {
  const VirtualDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const String viewType = 'nativeView';
    Map<String, dynamic> creationParams = <String, dynamic>{
      "textColor": theme.primaryColorLight.value,
      "backgroundColor": theme.primaryColorDark.value
    };

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Virtual Display"),
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
