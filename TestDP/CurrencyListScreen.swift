//
//  ViewController.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

final class CurrencyListScreen: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!

    fileprivate let viewModel = CurrencyListScreenViewModel()
//    fileprivate let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initSearchBar()
        initViewModel()
        viewModel.loadData()
    }
}

extension CurrencyListScreen {
    func initTableView() {
        tableView.register(UINib(nibName: viewModel.cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.cellReuseIdentifier)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
//        tableView.tableHeaderView = searchBar
    }

    func initSearchBar() {
        searchBar.delegate = viewModel
    }
}

extension CurrencyListScreen : CurrencyListScreenViewModelProtocol {

    func initViewModel() {
        viewModel.delegate = self
    }

    func didSelectRow(_ indexPath: IndexPath, with model: CurrencyModel) {
        if let currencyExchangeScreen = Storyboards.currencyExchange as? CurrencyExchangeScreen {
            currencyExchangeScreen.model = model
            navigationController?.pushViewController(currencyExchangeScreen, animated: true)
        } else {
            log("can't get \(Storyboards.Name.currencyExchange) storyboard")
        }
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    func error(text: String) {
        showText(text)
    }
}
