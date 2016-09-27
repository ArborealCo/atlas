//
//  BoardViewController.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/7/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit
import RealmSwift

class BoardViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    let dataSource = BoardDataSource()

    var realmUpdatedNotificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        collectionView.delegate = self

        let realm = try! Realm()
        realmUpdatedNotificationToken = realm.addNotificationBlock { (notification, realm) in
            self.collectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BoardViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        guard let item = dataSource.boardItems?[indexPath.row] else {
            return
        }

        if let boardItemCell = cell as? BoardItemCollectionViewCell {
            if let artist = item.artist {
                boardItemCell.titleLabel.text = artist.name
                boardItemCell.subtitleLabel.text = artist.genre
            } else if let album = item.album {
                boardItemCell.titleLabel.text = album.title
                let artistName = album.artistName
                let year = album.releaseDate?.formattedYear ?? ""
                if year.characters.count > 0 {
                    boardItemCell.subtitleLabel.text = "\(artistName) - \(year)"
                } else {
                    boardItemCell.subtitleLabel.text = "\(artistName)"
                }
            } else if let song = item.song {
                boardItemCell.titleLabel.text = song.name
                boardItemCell.subtitleLabel.text = "\(song.artistName) - \(song.albumName)"
            }
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= -50 {
            log.debug("Release to show search")
        }
    }

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView.contentOffset.y <= -50 else {
            return
        }

        guard let storyboard = storyboard else {
            return
        }

        let search = SearchViewController.makeFromStoryboard(storyboard)
        search.modalPresentationStyle = .OverCurrentContext
        search.modalTransitionStyle = .CrossDissolve
        presentViewController(search, animated: true, completion: nil)
    }

}
