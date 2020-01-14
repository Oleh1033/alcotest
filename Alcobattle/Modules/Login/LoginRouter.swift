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
}

// MARK: - Login MVC Components
extension LoginRouter {
    var viewModel: LoginViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! LoginViewModelApi
        // swiftlint:enable force_cast
    }
}
