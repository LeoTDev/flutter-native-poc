//
//  CanvasView.swift
//  Runner
//
//  Created by Leo Tome on 17/11/2023.
//

import Flutter
import UIKit


class CanvasViewFactory: NSObject, FlutterPlatformViewFactory {
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
        return CanvasPlatformView(
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

class CanvasPlatformView: NSObject, FlutterPlatformView {
    private var _view: CanvasView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = CanvasView()
        super.init()
    }

    func view() -> UIView {
        return _view
    }
}

class CanvasView: UIView, UIGestureRecognizerDelegate {
    var lines: [Line] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
        panGestureRecognizer.delegate = self
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func handlePan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let line = Line(startPoint: sender.location(in: self))
            lines.append(line)
            break
        case .changed:
            lines.last?.points.append(sender.location(in: self))
            setNeedsDisplay()
            break
        case .ended: break
        case .possible: break
        case .cancelled: break
        case .failed: break
        @unknown default: break
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        for line in lines {
            context.beginPath()
            context.setAlpha(1)
            context.setLineWidth(4)
            context.setStrokeColor(UIColor.red.cgColor)
            context.setLineCap(.round)
            context.move(to: line.startPoint)
            for point in line.points {
                context.addLine(to: point)
            }
            context.strokePath()
            //context.closePath()
        }
    }
}


class Line {
    var startPoint: CGPoint = .zero
    var points: [CGPoint] = []
    init(startPoint: CGPoint) {
        self.startPoint = startPoint
    }
}
