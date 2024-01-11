//
//  TimerHandler.swift
//  Runner
//
//  Created by Leo Tome on 15/12/2023.
//

import Foundation

class TimerHandler: NSObject, FlutterStreamHandler {
    // Handle events on the main thread.
    var timer = Timer()
    // Declare our eventSink, it will be initialized later
    private var eventSink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        print("onListen......")
        self.eventSink = eventSink
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "HH:mm:ss"
            let time = dateFormat.string(from: Date())
            eventSink(time)
        })
        
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
