//
//  AppDelegate.swift
//  Alcobattle
//
//  Created by Oleh on 26/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, GIDSignInUIDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
//        window = UIWindow(frame: UIScreen.main.bounds)
        launchInitialViewController()
        return true
    }
    
    func launchInitialViewController() {
         let appModule = true
             ? AppModules.login
             : AppModules.scannerOnboarding

         let module = appModule.build()
         module.router.show(inWindow: window, embedInNavController: true, setupData: nil, makeKeyAndVisible: true)
     }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Running sign in")
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            let idToken = user.authentication.idToken
            Authorization.shared.tokenGoogle = idToken!
            print(idToken)
        }
    }
}
