import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    WebModalPlugin.register(with: self.registrar(forPlugin: "FLTWebModalPlugin"));
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
