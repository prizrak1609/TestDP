//
//  CurrencyListCell.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

final class CurrencyListCell: UITableViewCell {
    @IBOutlet fileprivate weak var nameLabel: UILabel!

    var model: CurrencyListModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.name
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
}
