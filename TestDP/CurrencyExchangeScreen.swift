//
//  CurrencyExchangeScreen.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

fileprivate let segueIdentifier = "tabInfoController"

final class CurrencyExchangeScreen: UIViewController {
    @IBOutlet fileprivate weak var tabsScrollView: ScrollView!

    fileprivate let viewModel = CurrencyExchangeScreenViewModel()

    var model: CurrencyModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tabsScrollView.customDelegate = self
        viewModel.loadInfo(completion: tabsScrollView.addModels)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier,
            let containerVC = segue.destination as? ContainerViewController,
            let model = sender as? CurrencyModel {

            containerVC.model = model
        }
    }
}

extension CurrencyExchangeScreen : ScrollViewDelegate {

    func scrollViewSelected(model: CurrencyModel, in scrollView: ScrollView) {
        performSegue(withIdentifier: segueIdentifier, sender: model)
    }
}
