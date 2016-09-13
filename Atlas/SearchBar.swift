//
//  SearchBar.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/12/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit

class SearchBar: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var artistsFilterButton: UIButton!
    @IBOutlet weak var albumsFilterButton: UIButton!
    @IBOutlet weak var songsFilterButton: UIButton!

    enum SearchType {
        case Artists
        case Albums
        case Songs
    }

    var currentSearchType: SearchType! {
        didSet {
            if currentSearchType != oldValue {
                updateViewForCurrentSearchType()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentSearchType = .Artists
        searchTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
    }

    @IBAction func closeButtonTapped() {
        self.parentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func artistsButtonTapped() {
        currentSearchType = .Artists
    }

    @IBAction func albumsButtonTapped() {
        currentSearchType = .Albums
    }

    @IBAction func songsButtonTapped() {
        currentSearchType = .Songs
    }

}

private extension SearchBar {

    func updateViewForCurrentSearchType() {
        if currentSearchType == .Artists {
            artistsFilterButton.setTitleColor(UIColor.atlasBlue(), forState: .Normal)
        } else {
            artistsFilterButton.setTitleColor(UIColor.atlasGray(), forState: .Normal)
        }

        if currentSearchType == .Albums {
            albumsFilterButton.setTitleColor(UIColor.atlasBlue(), forState: .Normal)
        } else {
            albumsFilterButton.setTitleColor(UIColor.atlasGray(), forState: .Normal)
        }

        if currentSearchType == .Songs {
            songsFilterButton.setTitleColor(UIColor.atlasBlue(), forState: .Normal)
        } else {
            songsFilterButton.setTitleColor(UIColor.atlasGray(), forState: .Normal)
        }
    }

}
