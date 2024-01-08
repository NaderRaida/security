import UIKit
import Flutter
import Firebase
import GoogleMaps
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate{
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
  FirebaseApp.configure()
      if #available(iOS 10.0, *) {
        application.applicationIconBadgeNumber = 0 // For Clear Badge Counts
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications() // To remove all delivered notifications
        center.removeAllPendingNotificationRequests()
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: {_, _ in })
      } else {
          let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
      }
      application.registerForRemoteNotifications()
      GMSServices.provideAPIKey("AIzaSyCymQRHfF2bFL1lwmM6bjeI9eea1qH_YPY")
      GeneratedPluginRegistrant.register(with: self)

      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
