import UIKit
import Flutter
import GoogleMaps


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
 GMSServices.provideAPIKey("AIzaSyCv_XLgyHqS2JvGPGWVyttaSU_SlbNDoA0")
    GeneratedPluginRegistrant.register(with: self)

//     GMSServices.provideAPIKey("AIzaSyCv_XLgyHqS2JvGPGWVyttaSU_SlbNDoA0")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
