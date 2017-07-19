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
    @IBOutlet fileprivate weak var containerView: UIView!

    fileprivate let viewModel = CurrencyExchangeScreenViewModel()
    fileprivate var childViewController: ContainerViewController?

    var model: CurrencyModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tabsScrollView.customDelegate = self
        viewModel.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadInfo { [weak self] models in
            guard let welf = self else { return }
            welf.tabsScrollView.addModels(models)
            if let model = welf.model {
                welf.tabsScrollView.scrollTo(model)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier,
            childViewController == nil,
            let containerVC = segue.destination as? ContainerViewController {

            childViewController = containerVC
        }
        childViewController?.model = model
    }
}

extension CurrencyExchangeScreen : CurrencyExchangeScreenViewModelProtocol {

    func error(text: String) {
        showText(text)
    }
}

extension CurrencyExchangeScreen : ScrollViewDelegate {

    func scrollViewSelected(model: CurrencyModel, in scrollView: ScrollView) {
        // if remove this check and childViewController variable then
        // in runtime get error "There are unexpected subviews in the container view. Perhaps the embed segue has already fired once or a subview was added programmatically?"
        if childViewController == nil {
            performSegue(withIdentifier: segueIdentifier, sender: model)
        } else {
            childViewController?.model = model
            childViewController?.reloadInfo()
        }
    }
}
