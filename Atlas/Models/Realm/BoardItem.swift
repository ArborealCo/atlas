//
//  BoardItem.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/26/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import RealmSwift

class BoardItem: Object {
    dynamic var artist: Artist?
    dynamic var album: Album?
    dynamic var song: Song?
}
