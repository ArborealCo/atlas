//
//  SearchServiceSpec.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/17/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import Quick
import Nimble
import Moya
import RxSwift
import ObjectMapper
@testable import Atlas

class SearchServiceSpec: QuickSpec {

    override func spec() {
        var searchService: RxMoyaProvider<SearchService>!

        beforeEach {
            searchService = RxMoyaProvider<SearchService>(plugins: [NetworkLoggerPlugin()])
        }

        it("can find Opeth") {
            waitUntil(timeout: 10) { done in
            _ = searchService.request(.SearchArtists(term: "Opeth"))
                .filterSuccessfulStatusCodes()
                .mapJSON()
                .doOnNext { (json: AnyObject) in
                    done()

                    guard let jsonDict = json as? [String: AnyObject] else {
                        XCTFail("Failed to cast json as dictionary")
                        return
                    }

                    let results = ArtistSearch(JSON: jsonDict)
                    expect(results?.resultCount) == 1
                    if let firstArtist = results?.artists?.first {
                        expect(firstArtist.name) == "Opeth"
                        expect(firstArtist.iTunesURL.characters.count) > 0
                    } else {
                        XCTFail("No artists found!")
                    }
                }
                .doOnError({ (error) in
                    XCTFail("Failed to get artist 'Opeth': \(error)")
                    done()
                })
                .subscribe()
            }
        }
    }

}
