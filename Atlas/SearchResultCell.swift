//
//  SearchResultCell.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/12/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
    }

}
