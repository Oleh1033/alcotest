//
//  LoginRouter.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - LoginRouter class
final class LoginRouter: Router {
}

// MARK: - LoginRouter API
extension LoginRouter: LoginRouterApi {
    func goToCreateAcc() {
        let module = AppModules.createAcc.build()
        module.router.show(from: viewController, embedInNavController: true, setupData: nil)
    }
    func goToForgotPass() {
        let module = AppModules.forgotPass.build()
        module.router.show(from: viewController, embedInNavController: true, setupData: nil)
    }
    func goToMainTab() {
        let module = AppModules.mainTab.build()
        module.router.show(from: viewController, embedInNavController: true, setupData: nil)
    }
}

// MARK: - Login MVC Components
extension LoginRouter {
    var viewModel: LoginViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! LoginViewModelApi
        // swiftlint:enable force_cast
    }
}
