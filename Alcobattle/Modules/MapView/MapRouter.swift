//
//  MapRouter.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - MapRouter class
final class MapRouter: Router {
}

// MARK: - MapRouter API
extension MapRouter: MapRouterApi {
    func goToMainTab() {
        let module = AppModules.mainTab.build()
        module.router.show(from: viewController, embedInNavController: true, setupData: nil)
    }
    func goToHistory() {
        let module = AppModules.history.build()
        module.router.show(from: viewController, embedInNavController: true, setupData: nil)
    }
}

// MARK: - Map MVC Components
extension MapRouter {
    var viewModel: MapViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! MapViewModelApi
        // swiftlint:enable force_cast
    }
}
