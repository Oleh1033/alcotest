//
//  DesignableView.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//  Copyright © 2020 Oleh. All rights reserved.
//

import UIKit

protocol DesignableProtocol {
    var nib: String? { get }
}

@IBDesignable
class DesignableView: UIView, DesignableProtocol {

    var nib: String? {
      return  String(describing: type(of: self))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
    }

    open func setup() {
        xibSetup()
    }

    func xibSetup() {
        guard let nibName = self.nib else { return Logger.log(.error, "IBDesignable nib name not found or empty") }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
