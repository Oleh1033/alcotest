//
//  HistoryRouter.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - HistoryRouter class
final class HistoryRouter: Router {
}

// MARK: - HistoryRouter API
extension HistoryRouter: HistoryRouterApi {
    func goToMainTab() {
        let module = AppModules.mainTab.build()
        module.router.show(from: viewController, embedInNavController: true, setupData: nil)
    }
    func goToMapView() {
        let module = AppModules.map.build()
        module.router.show(from: viewController, embedInNavController: true, setupData: nil)
    }
}

// MARK: - History MVC Components
extension HistoryRouter {
    var viewModel: HistoryViewModelApi {
        // swiftlint:disable force_cast
        return _viewModel as! HistoryViewModelApi
        // swiftlint:enable force_cast
    }
}
