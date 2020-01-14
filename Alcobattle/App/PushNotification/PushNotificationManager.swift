////
////  PushNotificationManager.swift
////  Alcobattle
////
////  Created by Oleh on 13/01/2020.
////  Copyright © 2020 Oleh. All rights reserved.
////
//
//import Firebase
////import FirebaseMessaging
//import Foundation
////import RxSwift
//import UserNotifications
//
//class PushNotificationManager: NSObject {
//    private let coreService = CoreApiService()
//    private var disposeBag = DisposeBag()
//    private var tokenFCM: String?
//    lazy var userNotificationCenter: UNUserNotificationCenter = {
//        return UNUserNotificationCenter.current()
//    }()
//
//    func configure() {
//        configureFirebase()
//        enable()
//        userNotificationCenter.delegate = self
//        Messaging.messaging().delegate = self
//    }
//
//    private func configureFirebase() {
//        #if ENV_RELEASE
//        let filePath = Bundle.main.path(forResource: "GoogleService-Info-prod", ofType: "plist")
//        #else
//        let filePath = Bundle.main.path(forResource: "GoogleService-Info-dev", ofType: "plist")
//        #endif
//        guard let path = filePath, let fileopts = FirebaseOptions(contentsOfFile: path) else {
//            optionalFatalError("Couldn't load config file")
//            return
//        }
//        FirebaseApp.configure(options: fileopts)
//    }
//
//    func enable(tokenRegistration: Bool = false) {
//        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
//        userNotificationCenter.requestAuthorization(options: options) { success, _ in
//            if success && tokenRegistration {
//                DispatchQueue.main.async {
//                    UIApplication.shared.registerForRemoteNotifications()
//                    self.postFCMToken()
//                }
//            }
//        }
//    }
//
//    private func postFCMToken() {
//        guard let token = tokenFCM else { return }
//        let request = NotificationTokenRequest(token: token)
//        let response: Single<NotificationTokenResponse> = coreService.executeCommand(request)
//        response.subscribe().disposed(by: disposeBag)
//    }
//}
//
//extension PushNotificationManager: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        Logger.log(.info, fcmToken)
//        tokenFCM = fcmToken
//    }
//
//    func executeRegistrationNotificationToken(token: String) -> Single<NotificationTokenResponse> {
//        let request = NotificationTokenRequest(token: token)
//        return coreService.executeCommand(request)
//    }
//}
//
//extension PushNotificationManager: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert, .badge, .sound])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        guard let dictionary = response.notification.request.content.userInfo as? [String: Any] else { return }
//        do {
//            let a = try NotificationResponse.decode(from: dictionary)
//            let issueIdDouble = Double(a.issueId)
//            handleNotificationNavigations(issueIdDouble)
//        } catch _ {
//            handleNotificationNavigations()
//        }
//    }
//
//    func handleNotificationNavigations(_ issueId: Double? = nil) {
//
//        let notification = PaperlessNotification(type: .issueDetails, data: issueId)
//        print(notification)
//        if RestService.isTokenAlive {
//            AppModules.buildNavigationStack(notification.rootModule, modules: notification.navigationStack)
//        } else {
//            let module = AppModules.login.build()
//            module.router.show(inWindow: AppModules.window, embedInNavController: true, setupData: notification, makeKeyAndVisible: true)
//        }
//    }
//}
//
//extension AppDelegate {
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        #if ENV_DEVELOPMENT
//        Messaging.messaging().setAPNSToken(deviceToken, type: .sandbox)
//        #else
//        Messaging.messaging().setAPNSToken(deviceToken, type: .prod)
//        #endif
//    }
//}
