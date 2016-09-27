//
//  SearchViewController.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/9/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit
import PINRemoteImage
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var artistsButton: UIButton!
    @IBOutlet weak var albumsButton: UIButton!
    @IBOutlet weak var songsButton: UIButton!

    static func makeFromStoryboard(storyboard: UIStoryboard) -> SearchViewController {
        let vc = storyboard.instantiateViewControllerWithIdentifier("SearchViewController")
        // swiftlint:disable:next force_cast
        return vc as! SearchViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let footerView = UIView()
        footerView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = footerView
        tableView.delegate = self

        if let searchBar = self.childViewControllers.last as? SearchBar {
            let dataSource = searchBar.searchDataSource
            dataSource.whenUpdated = {
                self.tableView.reloadData()
            }
            tableView.dataSource = dataSource
        } else {
            log.error("Failed to bind search bar data source.")
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

extension SearchViewController: UITableViewDelegate {

    // swiftlint:disable:next line_length
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let albumCell = cell as? SearchResultCell,
            let dataSource = tableView.dataSource as? SearchDataSource {
            let result = dataSource.presentableSearchResults[indexPath.row]
            albumCell.titleLabel.text = result.title
            albumCell.subtitleLabel.text = result.subtitle

            if let imageURL = NSURL(string: result.imageURL)
                where result.imageURL.characters.count > 0 {
                albumCell.artImageView.pin_setImageFromURL(imageURL)
            } else {
                albumCell.artImageView.image = nil
                // TODO: no-image asset
            }
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let dataSource = tableView.dataSource as? SearchDataSource else {
            return
        }

        let result = dataSource.presentableSearchResults[indexPath.row]

        let realm = try! Realm()

        let boardItem = BoardItem()
        var itemShouldBeInserted = true
        if let artist = result as? Artist {
            boardItem.artist = artist
            itemShouldBeInserted = realm
                .objects(BoardItem)
                .filter("artist.id == \(artist.id)")
                .count == 0
        } else if let album = result as? Album {
            boardItem.album = album
            itemShouldBeInserted = realm
                .objects(BoardItem)
                .filter("album.id == \(album.id)")
                .count == 0
        } else if let song = result as? Song {
            boardItem.song = song
            itemShouldBeInserted = realm
                .objects(Song)
                .filter("song.id == \(song.id)")
                .count == 0
        }

        if itemShouldBeInserted {
            try! realm.write {
                realm.add(boardItem)
            }

            log.debug("added board item: \(boardItem)")
        }

        dismissViewControllerAnimated(true, completion: nil)
    }
}
