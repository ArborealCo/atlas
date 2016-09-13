//
//  BoardDataSource.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/8/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit

class BoardDataSource: NSObject, UICollectionViewDataSource {

    // swiftlint:disable:next line_length
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    // swiftlint:disable:next line_length
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            "BoardItemCellIdentifier",
            forIndexPath: indexPath)
        return cell
    }

}
