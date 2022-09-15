import UIKit
import Flutter
import GoogleMaps



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAsWiiZLhjHhTj830uzF-LsmXZFfrbl8g4")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


  override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey :   Any] = [:]) -> Bool {
    if (url.host! == "payment-return") {

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        controller.pushRoute("paymentDone");

        return true;
    }
    return false;
  }
}
