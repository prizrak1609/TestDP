//
//  CurrencyExchangeScreen.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

fileprivate let segueIdentifier = "tabInfoController"
fileprivate let buttonsBackgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
fileprivate let selectedButtonsBackgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)

final class CurrencyExchangeScreen: UIViewController {
    @IBOutlet fileprivate weak var tabsScrollView: ScrollView!
    @IBOutlet fileprivate weak var containerView: UIView!

    fileprivate let viewModel = CurrencyExchangeScreenViewModel()
    fileprivate var childViewController: ContainerViewController?

    var model: CurrencyModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currencies rate"
        tabsScrollView.customDelegate = self
        tabsScrollView.customDataSource = self
        tabsScrollView.backgroundColor = buttonsBackgroundColor
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
            let containerVC = segue.destination as? ContainerViewController {

            childViewController = containerVC
            containerVC.model = model
        }
    }
}

extension CurrencyExchangeScreen : CurrencyExchangeScreenViewModelProtocol {

    func error(text: String) {
        showText(text)
    }
}

extension CurrencyExchangeScreen : ScrollViewDelegate, ScrollViewDataSource {

    func scrollViewSelected(model: CurrencyModel, and view: UIView, in scrollView: ScrollView) {
        // if remove this check and childViewController variable then
        // in runtime get error "There are unexpected subviews in the container view. Perhaps the embed segue has already fired once or a subview was added programmatically?"
        if childViewController == nil {
            performSegue(withIdentifier: segueIdentifier, sender: model)
        } else {
            childViewController?.model = model
            childViewController?.reloadInfo()
        }
        scrollView.subviews.forEach { $0.backgroundColor = buttonsBackgroundColor }
        view.backgroundColor = selectedButtonsBackgroundColor
    }

    func scrollViewGetViewSize(in scrollView: ScrollView) -> CGSize {
        return CGSize(width: 40, height: scrollView.bounds.height)
    }

    func scrollViewGetView(from index: Int, with model: CurrencyModel, in scrollView: ScrollView) -> UIView {
        let label = UILabel(frame: CGRect.zero)
        label.text = model.name
        label.textAlignment = .center
        return label
    }
}
