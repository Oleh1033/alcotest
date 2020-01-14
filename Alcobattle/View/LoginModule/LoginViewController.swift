//
//  ViewController.swift
//  Alcobattle
//
//  Created by Oleh on 26/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON
import GoogleSignIn

class LoginViewController: UIViewController, LoginButtonDelegate,  UITextFieldDelegate, GIDSignInUIDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var testButton: UIButton!
    
    @IBOutlet weak var loginInput: FloatingInput!
    @IBOutlet weak var paswwordInput: FloatingInput!
    
    @IBOutlet weak var loginWithEmail: UIButton!
    @IBOutlet weak var createAcc: UIButton!
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chekIsLogged()
        
        setGoogleButton()
        setFacebookButton()
        
        setVie()
        dismissOnTap()
    }
    
    func chekIsLogged() {
        if Authorization.shared.isValidToken() {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainViewController") else { return }
            self.present(vc, animated: true, completion:  nil)
        }
    }
    
    func setFacebookButton() {
        let button = FBLoginButton()
        button.frame = CGRect(x: 120, y: 400, width: view.frame.width - 240, height: 30)
        button.permissions = ["public_profile", "email"]
        button.delegate = self
        self.view.addSubview(button)
    }
    
    func dismissOnTap() {
        self.view.isUserInteractionEnabled = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.view is GIDSignInButton {
            return false
        }
        return true
    }
    
    func setGoogleButton() {
        GIDSignIn.sharedInstance().uiDelegate = self
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.frame = CGRect(x: 120, y: 340, width: view.frame.width - 240, height: 30)
        view.addSubview(googleSignInButton)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
        } else {
            print("\(error.localizedDescription)")
        }
    }

    @IBAction func loginEmailAction(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainViewController") else { return }
        self.present(vc, animated: true, completion:  nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let er = error {
            print("some err", er)
        }
        print(JSON(result))
        print(result?.token?.tokenString)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("user log out")
    }
    
    @IBAction func testAction(_ sender: Any) {

        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"name, id, email"])) { httpResponse, result, error   in
            if error != nil {
                NSLog(error.debugDescription)
                print("some eroor")
                return
            }
            if let result = result as? [String:String] {
                let res = JSON(result)
                print("---------------------------",res)
                print(res["picture"])
            }
        }
        connection.start()
    }
    
    @IBAction func goReallyFB(_ sender: Any) {
        hud.textLabel.text = "Sign FB...."
        hud.show(in: view, animated: true)
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .success(granted: _, declined: _, token: _):
                print(result)
                print(JSON(result))
                print("first stage")
                self.hud.dismiss(animated: true)
                self.signInFirebase()
            case .failed(let err):
                print("err")
                self.hud.dismiss(animated: true)
            case .cancelled:
                self.hud.textLabel.text = "Cansel...."
                self.hud.dismiss(animated: true)
            }
        }
    }
    
    func signInFirebase() {
        guard let token2 = AccessToken.current?.tokenString else { return }

        print(token2)
        let credentials = FacebookAuthProvider.credential(withAccessToken: token2)
        Auth.auth().signIn(with: credentials) { (user, err) in
            if let err = err {
                print(err)
                return
            }
            print("succesfully sign in ______________", user)
            self.hud.dismiss(animated: true)
        }
    }

    @IBAction func getImage(_ sender: Any) {
        print("OUT")
        GIDSignIn.sharedInstance().signOut()
        let manager = LoginManager()
        manager.logOut()
    }
    
    @IBAction func goLoginFB(_ sender: Any) {
        hud.textLabel.text = "Sign anon...."
        hud.show(in: view, animated: true)
        Auth.auth().signInAnonymously { (user, err) in
            if let err = err {
                self.hud.dismiss(animated: true)
                print(err)
            } else {
                self.hud.dismiss(animated: true)
                print("Succesfully sign in with uid : ", user!.user)
            }
        }
    }
    
    func setVie() {
        loginInput.textLayer.string = "Login"
        paswwordInput.textLayer.string = "Password"
    }
}
