//
//  Album.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/23/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Album: Object, Mappable, Identifiable {

    dynamic var id: Int = 0

    dynamic var artistId: String = ""
    dynamic var artistName: String = ""
    dynamic var imageURL: String = ""
    dynamic var iTunesURL: String = ""
    dynamic var releaseDate: NSDate?
    dynamic var title: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(_ map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["collectionId"]

        artistId <- map["artistId"]
        artistName <- map["artistName"]
        imageURL <- map["artworkUrl100"]
        iTunesURL <- map["collectionViewUrl"]
        releaseDate <- (map["releaseDate"], ISO8601DateTransform())
        title <- map["collectionName"]
    }

}

extension Album: SearchResultPresentable {

    var subtitle: String {
        let year = releaseDate?.formattedYear ?? ""
        if year.characters.count == 0 {
            return artistName
        }

        return "\(artistName) - \(year)"
    }

}
