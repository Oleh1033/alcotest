//
//  PaperlessNotificationEntities.swift
//  Alcobattle
//
//  Created by Oleh on 13/01/2020.
//  Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

struct NotificationResponse: Codable {
    let issueId: String
}

enum NotificationType: Int, Codable {
    case issueDetails
}

struct PaperlessNotification {
    let type: NotificationType?
    let data: Any?

    var rootModule: AppModules {
        switch type {
        case .issueDetails:
            return .issuesList
        default:
            return .login
        }
    }

    var navigationStack: [RedirectionModule] {
        switch type {
        case .issueDetails?:
        return [
            RedirectionModule(appModule: .issueDetails, setupData: data)
        ]
        default:
            return [RedirectionModule(appModule: .issuesList, setupData: nil)]
        }
    }
}
