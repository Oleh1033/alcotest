//
//  LoginView.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import UIKit

//MARK: LoginView Class
final class LoginView: PaperlessUserInterface {
    
    @IBOutlet weak var inputLoginView: FloatingInput!
    @IBOutlet weak var inputPasswordView: FloatingInput!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAcc: UIButton!
    @IBOutlet weak var forgotPass: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        print("loginAction")
        router.goToMainTab()
    }
    @IBAction func createAccAction(_ sender: Any) {
        print("createAccAction")
        router.goToCreateAcc()
    }
    @IBAction func forgotPassAction(_ sender: Any) {
        print("forgotPassAction")
        router.goToForgotPass()
    }
}

//MARK: - LoginView API
extension LoginView: LoginViewApi {
}

// MARK: - LoginView MVC Components API
extension LoginView {
    var viewModel: LoginViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! LoginViewModelApi
        // swiftlint:enable force_cast
    }
    var displayData: LoginDisplayData {
        // swiftlint:disable force_cast
        return _displayData as! LoginDisplayData
        // swiftlint:enable force_cast
    }
    
    var router: LoginRouterApi {
        // swiftlint:disable force_cast
        return _router as! LoginRouterApi
        // swiftlint:enable force_cast
    }
}
