//
//  MVCModule.swift
//  PaperlessMove
//
//  Created by Piotr Gawlowski on 19/09/2019.
//  Copyright © 2019 Billennium. All rights reserved.
//

import UIKit

enum MVCViewType {
    case storyboard
    case nib
    case code
}

protocol MVCModule {
    var viewType: MVCViewType { get }
    var viewName: String { get }
    func build(bundle: Bundle, deviceType: UIUserInterfaceIdiom?) -> Module
}

extension MVCModule where Self: RawRepresentable, Self.RawValue == String {
    var viewType: MVCViewType {
        return .storyboard
    }

    var viewName: String {
        return rawValue
    }

    func build(bundle: Bundle = Bundle.main, deviceType: UIUserInterfaceIdiom? = nil) -> Module {
        return Module.build(self, bundle: bundle, deviceType: deviceType)
    }
}
