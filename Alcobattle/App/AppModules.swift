//
//  AppModules.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//  Copyright © 2020 Oleh. All rights reserved.
//

import UIKit

enum AppModules: String, Codable, MVCModule {
    case login
    case createAcc
    case forgotPass
    case mainTab
//    case mapView
    case history
    case map
}

struct RedirectionModule {
    let appModule: AppModules
    let setupData: Any?
}

//extension AppModules {
//    static var window: UIWindow? {
//        // swiftlint:disable all
//        return UIApplication.shared.delegate?.window ?? nil
//        // swiftlint:enable all
//    }
//
//    static func buildNavigationStack(_ rootModule: AppModules, modules: [RedirectionModule]) {
//        let moduleStack = modules.compactMap { module -> Module? in
//            let appModule = module.appModule.build()
//            appModule.viewModel.setupView(data: module.setupData)
//
//            return appModule
//        }
//
//        let rootModule = rootModule.build()
//        let navigationController = rootModule.router.embedInNavigationController() ?? UINavigationController()
//
//        let viewControllers = moduleStack.compactMap({ $0.view as? UIViewController })
//        navigationController.viewControllers.insert(contentsOf: viewControllers, at: 1)
//
//        AppModules.window?.switchRootViewController(to: navigationController)
//        AppModules.window?.makeKeyAndVisible()
//    }
//}
