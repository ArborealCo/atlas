//
//  SearchViewController.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/9/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit

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

private extension SearchViewController {

}

extension SearchViewController: UITableViewDelegate {

    // swiftlint:disable:next line_length
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let albumCell = cell as? SearchResultCell, let dataSource = tableView.dataSource as? SearchDataSource {
            let result = dataSource.presentableSearchResults[indexPath.row]
            albumCell.titleLabel.text = result.title
            albumCell.subtitleLabel.text = result.subtitle
            // TODO: Image
        }
    }
}
