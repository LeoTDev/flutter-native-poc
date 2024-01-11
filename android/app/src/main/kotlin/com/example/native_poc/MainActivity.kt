package com.example.native_poc

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val METHOD_CHANNEL = "com.test.library/nativeMethods"
    private val EVENT_CHANNEL = "timeHandlerEvent"

    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "randomNumber" -> {
                    val arg = (call.arguments as? List<*>)?.get(0) as? Int ?: 100
                    result.success((Math.random() * arg).toInt())
                }

                "startReverseInvocation" -> {
                    result.success(null)
                    reverseInvocation()
                }

                else -> {
                    result.notImplemented()
                }
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(StreamHandler)

        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("nativeView", NativeViewFactory())

        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("nativeViewGestures",
                        CanvasPlatformViewFactory())
    }

    private fun reverseInvocation() {
        Thread {
            for (i in 1..5) {
                runOnUiThread {
                    methodChannel.invokeMethod("updateState", (Math.random() * 10).toInt())
                }
                Thread.sleep(1000)
            }
        }.start()
    }
}
