//
//  MainTabViewModel.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - MainTabViewModel Class
final class MainTabViewModel: ViewModel {
}

// MARK: - MainTabViewModel API
extension MainTabViewModel: MainTabViewModelApi {
}

// MARK: - MainTab MVC Components
extension MainTabViewModel {
    var view: MainTabViewApi {
        // swiftlint:disable force_cast
        return _view as! MainTabViewApi
        // swiftlint:enable force_cast
    }
    var router: MainTabRouterApi {
        // swiftlint:disable force_cast
        return _router as! MainTabRouterApi
        // swiftlint:enable force_cast
    }
}
