//
//  UserInterface.swift
//  PaperlessMove
//
//  Created by Piotr Gawlowski on 19/09/2019.
//  Copyright © 2019 Billennium. All rights reserved.
//

import UIKit

public protocol UserInterfaceProtocol: class, MVCComponent {
    var _viewModel: ViewModelProtocol! { get set }
    var _router: RouterProtocol! { get set }
    var _displayData: DisplayData! { get set }

    var viewController: UIViewController { get }
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

public extension UserInterfaceProtocol {
    var viewController: UIViewController {
        //swiftlint:disable force_cast
        return self as! UIViewController
        //swiftlint:enable force_cast
    }
}

open class UserInterface: UIViewController, UserInterfaceProtocol {
    public var _viewModel: ViewModelProtocol!
    public var _router: RouterProtocol!
    public var _displayData: DisplayData!

    open override func viewDidLoad() {
        super.viewDidLoad()
        _viewModel.viewHasLoaded()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _viewModel.viewIsAboutToAppear()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _viewModel.viewHasAppeared()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _viewModel.viewIsAboutToDisappear()
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _viewModel.viewHasDisappeared()
    }
}
