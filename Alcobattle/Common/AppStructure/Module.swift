//
//  Module.swift
//  PaperlessMove
//
//  Created by Piotr Gawlowski on 19/09/2019.
//  Copyright © 2019 Billennium. All rights reserved.
//

import Foundation
import UIKit

private let kTabletSuffix = "Pad"

public protocol MVCComponent {
    init()
}

enum Component: String {
    case view
    case viewModel
    case router
    case displayData
}

public struct Module {

    public private(set) var view: UserInterfaceProtocol
    public private(set) var viewModel: ViewModelProtocol
    public private(set) var router: RouterProtocol

    static func build<T: RawRepresentable & MVCModule>(_ module: T, bundle: Bundle = Bundle.main, deviceType: UIUserInterfaceIdiom? = nil) -> Module where T.RawValue == String {
        //swiftlint:disable force_cast
        let viewModelClass = module.classForMVCComponent(.viewModel, bundle: bundle) as! ViewModelProtocol.Type
        let routerClass = module.classForMVCComponent(.router, bundle: bundle) as! RouterProtocol.Type
        let displayDataClass = module.classForMVCComponent(.displayData, bundle: bundle) as! DisplayData.Type
        //swiftlint:enable force_cast

        let view = loadView(forModule: module, bundle: bundle, deviceType: deviceType)
        view.viewController.restorationIdentifier = module.viewName
        let viewModel = viewModelClass.init()
        let router = routerClass.init()
        let displayData = displayDataClass.init()

        return build(view: view, viewModel: viewModel, router: router, displayData: displayData)
    }
}

// MARK: - Helper Methods
private extension Module {

    static func loadView<T: RawRepresentable & MVCModule>(forModule module: T, bundle: Bundle, deviceType: UIUserInterfaceIdiom? = nil) -> UserInterfaceProtocol where T.RawValue == String {
        //swiftlint:disable force_cast
        let viewClass = module.classForMVCComponent(.view, bundle: bundle, deviceType: deviceType) as! UIViewController.Type
        //swiftlint:enable force_cast
        let viewIdentifier = safeString(NSStringFromClass(viewClass).components(separatedBy: ".").last)
        let viewName = module.viewName.uppercasedFirst

        //swiftlint:disable force_cast
        switch module.viewType {
        case .storyboard:
            let sb = UIStoryboard(name: viewName, bundle: bundle)
            return sb.instantiateViewController(withIdentifier: viewIdentifier) as! UserInterfaceProtocol
        case .nib:
            return viewClass.init(nibName: viewName, bundle: bundle) as! UserInterfaceProtocol
        case .code:
            return viewClass.init() as! UserInterfaceProtocol
        }
        //swiftlint:enable force_cast
    }

    static func build(view: UserInterfaceProtocol, viewModel: ViewModelProtocol, router: RouterProtocol, displayData: DisplayData) -> Module {
        view._viewModel = viewModel
        view._router = router
        view._displayData = displayData
        viewModel._router = router
        viewModel._view = view
        var router = router
        router._viewModel = viewModel

        return Module(view: view, viewModel: viewModel, router: router)
    }
}

// MARK: - Private Extension for Application Module generic enum
private extension RawRepresentable where RawValue == String {

    func classForMVCComponent(_ component: Component, bundle: Bundle, deviceType: UIUserInterfaceIdiom? = nil) -> Swift.AnyClass? {
        let name = className(for: component)
        let bundleName = safeString(bundle.infoDictionary?["CFBundleName"])
        let classInBundle = (bundleName + "." + name).replacingOccurrences(of: " ", with: "_")

        if component == .view {
            let deviceType = deviceType ?? UIScreen.main.traitCollection.userInterfaceIdiom
            let isPad = deviceType == .pad
            if isPad, let tabletView = NSClassFromString(classInBundle + kTabletSuffix) {
                return tabletView
            }
        }

        return NSClassFromString(classInBundle)
    }

    func className(for component: Component) -> String {
        return rawValue.uppercasedFirst + component.rawValue.uppercasedFirst
    }
}

extension Module {

}

extension String {
    var first: String {
        return String(prefix(1))
    }
    var uppercasedFirst: String {
        return first.uppercased() + String(dropFirst())
    }
}

func safeString(_ value: Any?) -> String {
    guard let text = value else { return "" }
    return String(describing: text)
}
