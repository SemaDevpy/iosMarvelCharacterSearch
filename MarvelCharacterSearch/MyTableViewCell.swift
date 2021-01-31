//
//  MyTableViewCell.swift
//  MarvelCharacterSearch
//
//  Created by Syimyk on 1/31/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer.cornerRadius = 10
    }

    

}
