//
//  BoardDataSource.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/8/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit
import RealmSwift

class BoardDataSource: NSObject, UICollectionViewDataSource {

    var boardItems: Results<BoardItem>?

    override init() {
        super.init()

        let realm = try! Realm()
        boardItems = realm.objects(BoardItem)
    }

    // swiftlint:disable:next line_length
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardItems?.count ?? 0
    }

    // swiftlint:disable:next line_length
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            "BoardItemCellIdentifier",
            forIndexPath: indexPath)
        return cell
    }

}
