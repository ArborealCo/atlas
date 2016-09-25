//
//  SearchDataSource.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/12/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import ObjectMapper

class SearchDataSource: NSObject {

    var presentableSearchResults: [SearchResultPresentable] {
        guard let searchType = currentSearchType else {
            return []
        }

        switch searchType {
        case .Artists:
            return artistSearchResults ?? []
        case .Albums:
            return albumSearchResults ?? []
        case .Songs:
            return []
        }
    }

    var whenUpdated: (() -> Void)?

    private let searchService = RxMoyaProvider<SearchService>()
    private let disposeBag = DisposeBag()

    var currentSearchType: SearchType?
    private var artistSearchResults: [Artist]?
    private var albumSearchResults: [Album]?

    func search(term: String, type: SearchType) {
        currentSearchType = type

        switch type {
        case .Artists:
            searchForArtist(term)
        case .Albums:
            searchForAlbum(term)
        case.Songs:
            break // TODO
        }
    }

}

// MARK: Private
private extension SearchDataSource {

    func searchForArtist(term: String) {
        searchService.request(.SearchArtists(term: term))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .doOnNext { json in
                guard let jsonDict = json as? [String: AnyObject] else {
                    return
                }

                let artistsJSON = jsonDict["results"]

                if let artists = Mapper<Artist>().mapArray(artistsJSON) {
                    self.artistSearchResults = artists
                    self.whenUpdated?()
                } else {
                    log.error("Failed to map artist JSON")
                }
            }
            .subscribe()
            .addDisposableTo(disposeBag)
    }

    func searchForAlbum(term: String) {
        searchService.request(.SearchAlbums(term: term))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .doOnNext { json in
                guard let jsonDict = json as? [String: AnyObject] else {
                    return
                }

                let albumsJSON = jsonDict["results"]

                if let albums = Mapper<Album>().mapArray(albumsJSON) {
                    self.albumSearchResults = albums
                    self.whenUpdated?()
                } else {
                    log.error("Failed to map album JSON")
                }
            }
            .subscribe()
            .addDisposableTo(disposeBag)
    }

}

// MARK: UITableVIewDataSource
extension SearchDataSource: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchType = currentSearchType else {
            log.debug("No search type set.")
            return 0
        }

        switch searchType {
        case .Artists:
            return artistSearchResults?.count ?? 0
        case .Albums:
            return albumSearchResults?.count ?? 0
        case .Songs:
            return 0
        }
    }

    // swiftlint:disable:next line_length
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("SearchResultCellIdentifier")!
    }

}
