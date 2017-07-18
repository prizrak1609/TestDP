//
//  CurrencyInfoCell.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

final class CurrencyInfoCell: UITableViewCell {
    @IBOutlet fileprivate weak var currenciesLabel: UILabel!
    @IBOutlet fileprivate weak var currencyValueLabel: UILabel!

    var model: CurrencyInfoModel? {
        didSet {
            guard let model = model else { return }
            currenciesLabel.text = "\(model.from)/\(model.to)"
            currencyValueLabel.text = "\(model.value)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
}
