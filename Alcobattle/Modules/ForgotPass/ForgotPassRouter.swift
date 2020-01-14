//
//  ForgotPassRouter.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - ForgotPassRouter class
final class ForgotPassRouter: Router {
}

// MARK: - ForgotPassRouter API
extension ForgotPassRouter: ForgotPassRouterApi {
}

// MARK: - ForgotPass MVC Components
extension ForgotPassRouter {
    var viewModel: ForgotPassViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! ForgotPassViewModelApi
        // swiftlint:enable force_cast
    }
}
