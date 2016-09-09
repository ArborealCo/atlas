//
//  Logging.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/9/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import Log

let log = Logger(formatter: .Detailed, theme: .TomorrowNight)

extension Formatters {
    static let Detailed = Formatter("[%@] %@.%@:%@ %@: %@", [
        .Date("yyyy-MM-dd HH:mm:ss.SSS"),
        .File(fullPath: false, fileExtension: false),
        .Function,
        .Line,
        .Level,
        .Message
        ])
}

extension Themes {
    static let TomorrowNight = Theme(
        trace:   "#C5C8C6",
        debug:   "#81A2BE",
        info:    "#B5BD68",
        warning: "#F0C674",
        error:   "#CC6666"
    )
}
