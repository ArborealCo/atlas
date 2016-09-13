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

    let dataSource = SearchDataSource()

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
        tableView.dataSource = dataSource
    }

}

extension SearchViewController: UITableViewDelegate {

    // swiftlint:disable:next line_length
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let albumCell = cell as? SearchResultCell {
            albumCell.titleLabel.text = "Sorceress"
            albumCell.subtitleLabel.text = "Opeth - 2016"
        }
    }
}
