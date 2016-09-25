//
//  Song.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/24/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Song: Object, Mappable, Identifiable {

    dynamic var id: String = ""

    dynamic var albumName: String = ""
    dynamic var artistName: String = ""
    dynamic var imageURL: String = ""
    dynamic var name: String = ""


    override class func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(_ map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["trackId"]

        albumName <- map["collectionName"]
        artistName <- map["artistName"]
        imageURL <- map["artworkUrl100"]
        name <- map["trackName"]
    }

}

extension Song: SearchResultPresentable {

    var title: String {
        return name
    }

    var subtitle: String {
        return "\(artistName) - \(albumName)"
    }

}
