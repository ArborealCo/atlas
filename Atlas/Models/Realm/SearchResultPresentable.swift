//
//  SearchResultPresentable.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/23/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import Foundation

@objc protocol SearchResultPresentable {

    var title: String { get }
    var subtitle: String { get }
    var imageURL: String { get }

}
