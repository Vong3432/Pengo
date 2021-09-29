import UIKit
import Flutter
import Firebase
import GoogleMaps
import flutter_config

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
        
        if let apiKey = FlutterConfigPlugin.env(for: "IOS_MAPS_API_KEY") {
            GMSServices.provideAPIKey(apiKey)
        }
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
