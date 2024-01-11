import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var methodChannel: FlutterMethodChannel {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let aux = FlutterMethodChannel(name: "com.test.library/nativeMethods",
                                           binaryMessenger: controller.binaryMessenger)
        return aux
    }
    
    var eventChannel: FlutterEventChannel {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let aux = FlutterEventChannel(name: "timeHandlerEvent", binaryMessenger: controller.binaryMessenger)
        return aux
    }
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        GeneratedPluginRegistrant.register(with: self)
        
        weak var registrar = self.registrar(forPlugin: "plugin-name")
        
        registrar!.register(
            FLNativeViewFactory(messenger: registrar!.messenger()),
            withId: "nativeView")
        
        registrar!.register(
            CanvasViewFactory(messenger: registrar!.messenger()),
            withId: "nativeViewGestures")
        
        methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "randomNumber":
                let arg = (call.arguments as? NSArray)?[0] as? Int ?? 100
                result(Int.random(in: 0...arg))
            case "startReverseInvocation": self.reverseInvocation()
            default: result(FlutterMethodNotImplemented)
            }
        })
        
        eventChannel.setStreamHandler(TimerHandler())
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func reverseInvocation() {
        DispatchQueue.global().async {
            for _ in 0..<5 {
                DispatchQueue.main.async {
                    self.methodChannel.invokeMethod("updateState", arguments: Int.random(in: 0...10))
                }
                sleep(1)
            }
        }
    }
}
