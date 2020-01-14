//
//  HistoryModuleApi.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

//MARK: - HistoryRouter API
protocol HistoryRouterApi: RouterProtocol {
    func goToMainTab()
    func goToMapView()
}

//MARK: - HistoryView API
protocol HistoryViewApi: PaperlessUserInterfaceProtocol {
}

//MARK: - HistoryViewModel API
protocol HistoryViewModelApi: ViewModelProtocol {
}
