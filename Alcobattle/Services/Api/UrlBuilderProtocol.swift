//
//  UrlBuilderProtocol.swift
//  Alcobattle
//
//  Created by Oleh on 29/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import Foundation

class UrlBuilder {
    
    static let shared = UrlBuilder()
    
    func buildStringUrl(endpoint: UrlEnum) -> String {
        let url = "\(ConstantUrl.baseUrlApi)\(endpoint.rawValue)"
        return url
    }
}
