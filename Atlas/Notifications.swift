//
//  Notifications.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/23/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import Foundation

enum Notification: String {

    case SearchResultsReturned = "co.arboreal.searchResultsReturned"

}

extension NSNotificationCenter {

    func post(notification: Notification) {
        postNotificationName(notification.rawValue, object: nil)
    }

    func subscribe(observer: AnyObject, selector: Selector, notification: Notification, object: AnyObject? = nil) {
        // swiftlint:disable:previous line_length
        addObserver(observer, selector: selector, name: notification.rawValue, object: object)
    }

}
