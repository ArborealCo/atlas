//
//  Artist.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/21/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Artist: Object, Mappable {

    dynamic var name: String = ""
    dynamic var iTunesURL: String = ""
    dynamic var genre: String = ""

    required convenience init?(_ map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["artistName"]
        iTunesURL <- map["artistLinkUrl"]
        genre <- map["primaryGenreName"]
    }

}

extension Artist: SearchResultPresentable {

    var title: String {
        return name
    }

    var subtitle: String {
        return genre
    }

    var imageURL: String {
        return ""
    }

}
