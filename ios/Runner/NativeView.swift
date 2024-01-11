//
//  NativeView.swift
//  Runner
//
//  Created by Leo Tome on 10/11/2023.
//

import Flutter
import UIKit

extension Int {
    func toUIColor() -> UIColor {
        let alpha = (self >> 24) & 0xFF
        let red = (self >> 16) & 0xFF
        let green = (self >> 8) & 0xFF
        let blue = self & 0xFF
        return UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0)
    }
}


class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        let dictionary = args as! Dictionary<String, Any> as Dictionary
        let textColor = dictionary["textColor"] as! Int
        let backgroundColor = dictionary["backgroundColor"] as! Int
        createNativeView(
            view: _view,
            textColor: textColor.toUIColor(),
            backgroundColor: backgroundColor.toUIColor())
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView, textColor: UIColor, backgroundColor: UIColor){
        _view.backgroundColor = backgroundColor
        let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = textColor
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        _view.addSubview(nativeLabel)
    }
}
