//
//  HistoryViewModel.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

// MARK: - HistoryViewModel Class
final class HistoryViewModel: ViewModel {
}

// MARK: - HistoryViewModel API
extension HistoryViewModel: HistoryViewModelApi {
}

// MARK: - History MVC Components
extension HistoryViewModel {
    var view: HistoryViewApi {
        // swiftlint:disable force_cast
        return _view as! HistoryViewApi
        // swiftlint:enable force_cast
    }
    var router: HistoryRouterApi {
        // swiftlint:disable force_cast
        return _router as! HistoryRouterApi
        // swiftlint:enable force_cast
    }
}
