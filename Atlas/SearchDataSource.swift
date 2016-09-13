//
//  SearchDataSource.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/12/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit

class SearchDataSource: NSObject, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // swiftlint:disable:next line_length
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("SearchResultCellIdentifier")!
    }

}
