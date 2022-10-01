import UIKit
import SwiftUI
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
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
      let METHOD_CHANNEL_NAME = "com.startActivity/klarnaChannel"
      
      let klarnaChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
      
      klarnaChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          
          if (call.method == "StartKlarnaActivity"){
              
              if let args = call.arguments as? Dictionary<String, Any>,
                let clientToken = args["clientToken"] as? String {
                  
                  let klarnaHostingController = UIHostingController(rootView: KlarnaWrapperView(result: result))
                  
                  let parentViewController = UIViewController()
                  klarnaHostingController.view.translatesAutoresizingMaskIntoConstraints = false
                  klarnaHostingController.view.frame = parentViewController.view.bounds
                  // First, add the view of the child to the view of the parent
                  parentViewController.view.addSubview(klarnaHostingController.view)
                  // Then, add the child to the parent
                  parentViewController.addChild(klarnaHostingController)
                  
                  controller.view.addSubview(parentViewController.view)
                  
              } else {
                result(FlutterError.init(code: "errorSetDebug", message: "data or format error", details: nil))
              }
          }
      })
      
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      
  }
}
