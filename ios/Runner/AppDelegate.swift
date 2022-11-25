import UIKit
import Flutter
import GoogleMaps

 @UIApplicationMain
 @objc class AppDelegate: FlutterAppDelegate {
   override func application(
     _ application: UIApplication,
     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
   ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDfE0Q-5svv9v5syFCahOB8LN7Boq3rOqA")
     GeneratedPluginRegistrant.register(with: self)
     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
   }
   }