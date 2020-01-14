//
//  Router.swift
//  PaperlessMove
//
//  Created by Piotr Gawlowski on 19/09/2019.
//  Copyright © 2019 Billennium. All rights reserved.
//

import UIKit

public protocol RouterProtocol: MVCComponent {
    var _viewModel: ViewModelProtocol! { get set }
    var _view: UserInterfaceProtocol! { get }

    func embedInNavigationController() -> UINavigationController
    func show(inWindow window: UIWindow?, embedInNavController: Bool, setupData: Any?, makeKeyAndVisible: Bool)
    func show(from: UIViewController, embedInNavController: Bool, setupData: Any?)
    func show(from containerView: UIViewController, insideView targetView: UIView, setupData: Any?)
    func present(from: UIViewController, embedInNavController: Bool, presentationStyle: UIModalPresentationStyle, transitionStyle: UIModalTransitionStyle, setupData: Any?, completion: (() -> Void)?)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}

extension RouterProtocol {
    func present(from: UIViewController, embedInNavController: Bool = false,
                 presentationStyle: UIModalPresentationStyle = .fullScreen, transitionStyle: UIModalTransitionStyle = .coverVertical,
                 setupData: Any? = nil, completion: (() -> Void)? = nil) {
        return present(from: from, embedInNavController: embedInNavController,
                       presentationStyle: presentationStyle, transitionStyle: transitionStyle,
                       setupData: setupData, completion: completion)
    }
}

public extension RouterProtocol {
    var viewController: UIViewController {
        //swiftlint:disable force_cast
        return _view as! UIViewController
        //swiftlint:enable force_cast
    }
}

open class Router: RouterProtocol {
    public weak var _viewModel: ViewModelProtocol!
    public var _view: UserInterfaceProtocol! {
        return _viewModel._view
    }

    open func embedInNavigationController() -> UINavigationController {
        return getNavigationController() ?? UINavigationController(rootViewController: viewController)
    }

    open func show(inWindow window: UIWindow?, embedInNavController: Bool = false, setupData: Any? = nil, makeKeyAndVisible: Bool = true) {
        process(setupData: setupData)
        let view = embedInNavController ? embedInNavigationController() : viewController
        window?.rootViewController = view
        if makeKeyAndVisible {
            window?.makeKeyAndVisible()
        }
    }

    open func show(from: UIViewController, embedInNavController: Bool = false, setupData: Any? = nil) {
        process(setupData: setupData)
        let view: UIViewController = embedInNavController ? embedInNavigationController() : viewController
        view.modalPresentationStyle = .fullScreen
        from.show(view, sender: nil)
    }

    public func show(from containerView: UIViewController, insideView targetView: UIView, setupData: Any? = nil) {
        process(setupData: setupData)
        addAsChildView(ofView: containerView, insideContainer: targetView)
    }

    open func present(from: UIViewController, embedInNavController: Bool = false, presentationStyle: UIModalPresentationStyle = .fullScreen, transitionStyle: UIModalTransitionStyle = .coverVertical, setupData: Any? = nil, completion: (() -> Void)? = nil) {
        let view: UIViewController = embedInNavController ? embedInNavigationController() : viewController
        view.modalTransitionStyle = transitionStyle
        view.modalPresentationStyle = presentationStyle

        process(setupData: setupData)
        from.present(view, animated: true, completion: completion)
    }

    public func dismiss(animated flag: Bool = true, completion: (() -> Void)? = nil) {
        viewController.dismiss(animated: flag, completion: completion)
    }

    func popToModule<T: MVCModule>(_ module: T) {
        guard let vcToPop = viewController.navigationController?.children.first(where: { $0.restorationIdentifier == module.viewName }) else {
            return
        }
        viewController.navigationController?.popToViewController(vcToPop, animated: true)
    }

    required public init() { }
}

// MARK: - Process possible setup data
private extension Router {
    func process(setupData: Any?) {
        if let data = setupData {
            _viewModel.setupView(data: data)
        }
    }
}

// MARK: - Get navigation controller helper
public extension RouterProtocol {
    func getNavigationController() -> UINavigationController? {
        guard let view = _view as? UIViewController else { return nil }
        if let nav = view.navigationController {
            return nav
        } else if let parent = view.parent {
            if let parentNav = parent.navigationController {
                return parentNav
            }
        }
        return nil
    }
}

// MARK: - Embed view in a container view
public extension RouterProtocol {
    func addAsChildView(ofView parentView: UIViewController, insideContainer containerView: UIView) {
        guard let view = _view as? UIViewController else { return }
        parentView.addChild(view)
        containerView.addSubview(view.view)
        stretchToBounds(containerView, view: view.view)
        view.didMove(toParent: parentView)
    }

    private func stretchToBounds(_ holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let pinDirections: [NSLayoutConstraint.Attribute] = [.top, .bottom, .left, .right]
        let pinConstraints = pinDirections.map { direction -> NSLayoutConstraint in
            return NSLayoutConstraint(item: view, attribute: direction, relatedBy: .equal,
                                      toItem: holderView, attribute: direction, multiplier: 1.0, constant: 0)
        }
        holderView.addConstraints(pinConstraints)
    }
}
