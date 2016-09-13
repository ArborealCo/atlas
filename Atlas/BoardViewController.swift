//
//  BoardViewController.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/7/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    let dataSource = BoardDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BoardViewController: UICollectionViewDelegate {

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
