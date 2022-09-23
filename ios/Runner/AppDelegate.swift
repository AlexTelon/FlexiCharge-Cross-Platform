import UIKit
import Flutter
import GoogleMaps
import KlarnaMobileSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAsWiiZLhjHhTj830uzF-LsmXZFfrbl8g4")
    GeneratedPluginRegistrant.register(with: self)
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
      let METHOD_CHANNEL_NAME = "com.startActivity/klarnaChannel"
      
      let klarnaChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
      
      klarnaChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          
          if (call.method == "StartKlarnaActivity"){
              //TODO show Klarna payment view
              
          }
      })
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
