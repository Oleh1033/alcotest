//
//  MainTabRouter.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - MainTabRouter class
final class MainTabRouter: Router {
}

// MARK: - MainTabRouter API
extension MainTabRouter: MainTabRouterApi {
    func goToHistory() {
        let module = AppModules.history.build()
        module.router.show(from: viewController, embedInNavController: true, setupData: nil)
    }
    func goMapView() {
        let module = AppModules.map.build()
        module.router.show(from: viewController, embedInNavController: true, setupData: nil)
    }
}

// MARK: - MainTab MVC Components
extension MainTabRouter {
    var viewModel: MainTabViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! MainTabViewModelApi
        // swiftlint:enable force_cast
    }
}
