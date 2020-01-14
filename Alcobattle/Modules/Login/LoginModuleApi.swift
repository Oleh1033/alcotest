//
//  LoginModuleApi.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//Copyright © 2020 Oleh. All rights reserved.
//

//MARK: - LoginRouter API
protocol LoginRouterApi: RouterProtocol {
    func goToCreateAcc()
    func goToForgotPass()
    func goToMainTab()
}

//MARK: - LoginView API
protocol LoginViewApi: PaperlessUserInterfaceProtocol {
}

//MARK: - LoginViewModel API
protocol LoginViewModelApi: ViewModelProtocol {
}
