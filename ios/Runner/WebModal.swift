//
//  WebModal.swift
//  Runner
//
//  Created by Jeff Ward on 12/8/17.
//  Copyright © 2017 The Chromium Authors. All rights reserved.
//

import UIKit
import Flutter
import SafariServices

class WebModalPlugin: NSObject {
    var currentSession: WebModalSession?
    
}

extension WebModalPlugin: FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel.init(name: "plugins.flutter.io/webmodal", binaryMessenger: registrar.messenger())
        let plugin = WebModalPlugin.init()
        registrar.addMethodCallDelegate(plugin, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments
        switch call.method {
        case "present":
            if let args = args as? NSDictionary,
                let uri = args["url"] as? String {
                currentSession = WebModalSession.init(self, result)
                currentSession!.present(uri: uri)
            }
        case "close":
            if let currentSession = currentSession {
                currentSession.close()
            }
            result(nil)
        default:
            break
        }
        
    }
}

class WebModalSession: NSObject {
    let parent: WebModalPlugin
    let result: FlutterResult
    var vc: SFSafariViewController! = nil
    
    init(_ parent: WebModalPlugin, _ flutterResult: @escaping FlutterResult) {
        self.parent = parent
        self.result = flutterResult
    }
    
    func present(uri: String) {
        guard let delegate = UIApplication.shared.delegate,
            let window = delegate.window!,
            let rvc = window.rootViewController else {
                let error = FlutterError.init(code: "Error", message: "Could not find root view controller for app", details: nil)
                result(error)
                return;
        }
        
        vc = SFSafariViewController.init(url: URL.init(string: uri)!)
        vc.delegate = self
        vc.dismissButtonStyle = .cancel
        vc.configuration.barCollapsingEnabled = false
        rvc.present(vc, animated: true, completion: nil)
    }
    
    func close() {
        guard let vc = vc else {
            return
        }
        vc.dismiss(animated: true, completion: nil)
        parent.currentSession = nil
        result(nil)
    }
}

extension WebModalSession: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        parent.currentSession = nil
        result(nil)
    }
}
