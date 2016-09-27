//
//  Artist.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/21/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Artist: Object, Mappable, Identifiable {

    dynamic var id: Int = 0

    dynamic var genre: String = ""
    dynamic var iTunesURL: String = ""
    dynamic var name: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(_ map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["artistId"]

        genre <- map["primaryGenreName"]
        iTunesURL <- map["artistLinkUrl"]
        name <- map["artistName"]
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
