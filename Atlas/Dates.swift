//
//  Dates.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/24/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import Foundation

extension NSDate {

    struct Date {
        static let formatterYear: NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy"
            return formatter
        }()
    }

    var formattedYear: String {
        return Date.formatterYear.stringFromDate(self)
    }

}
