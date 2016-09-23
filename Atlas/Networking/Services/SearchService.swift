//
//  SearchService.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/17/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import Moya

enum SearchService {

    case SearchArtists(term: String)
    case SearchAlbums(term: String)
    case SearchSongs(term: String)

}

extension SearchService: TargetType {

    var baseURL: NSURL {
        return NSURL(string: "https://itunes.apple.com/")!
    }

    var path: String {
        return "search"
    }

    var method: Moya.Method {
        return .GET
    }

    var parameters: [String: AnyObject]? {
        var params = [String: AnyObject]()

        switch self {
        case .SearchAlbums(let album):
            params["term"] = album
            params["entity"] = "album"
        case .SearchArtists(let artist):
            params["term"] = artist
            params["entity"] = "musicArtist"
        case .SearchSongs(let song):
            params["term"] = song
            params["entity"] = "song"
        }

        params["limit"] = 10

        return params
    }

    var sampleData: NSData {
        return NSData() // TODO
    }

    var multipartBody: [MultipartFormData]? {
        return nil
    }

}
