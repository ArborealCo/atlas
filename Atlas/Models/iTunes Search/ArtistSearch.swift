//
//  ArtistSearch.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/21/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import ObjectMapper

class ArtistSearch: Mappable {

    var resultCount: Int?
    var artists: [Artist]?

    required init?(_ map: Map) {
    }

    // Mappable
    func mapping(map: Map) {
        resultCount <- map["resultCount"]
        artists <- map["results"]
    }

}
