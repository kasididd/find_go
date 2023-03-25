import UIKit
import Flutter
import GoogleMaps
import flutter_background_service_ios
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
override func application(
_ application: UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
GeneratedPluginRegistrant.register(with: self)
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.custom.task.identifier"
//TODO chang Goolge Key for IOS
GMSServices.provideAPIKey("AIzaSyCsa1Iq5Lg46Dlx4Glvdkhk01hnlxwUWJI")
return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
}