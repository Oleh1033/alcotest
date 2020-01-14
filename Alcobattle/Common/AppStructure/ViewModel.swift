//
//  ViewModel.swift
//  PaperlessMove
//
//  Created by Piotr Gawlowski on 19/09/2019.
//  Copyright © 2019 Billennium. All rights reserved.
//

import UIKit

public protocol ViewModelProtocol: class, MVCComponent {
    var _view: UserInterfaceProtocol! { get set }
    var _router: RouterProtocol! { get set }

    func setupView(data: Any)
    func viewHasLoaded()
    func viewIsAboutToAppear()
    func viewHasAppeared()
    func viewIsAboutToDisappear()
    func viewHasDisappeared()
}

open class ViewModel: ViewModelProtocol {
    public weak var _view: UserInterfaceProtocol!
    public var _router: RouterProtocol!

    required public init() { }

    open func setupView(data: Any) {
        print("setupView method not implemented")
    }

    open func viewHasLoaded() {}
    open func viewIsAboutToAppear() {}
    open func viewHasAppeared() {}
    open func viewIsAboutToDisappear() {}
    open func viewHasDisappeared() {}
}
