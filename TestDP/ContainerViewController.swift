//
//  ContainerViewController.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

final class ContainerViewController: UIViewController {
    @IBOutlet fileprivate weak var tableView: UITableView!

    fileprivate let viewModel = ContainerViewControllerViewModel()

    var model: CurrencyModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initViewModel()
        reloadInfo()
    }

    func reloadInfo() {
        viewModel.loadInfo(model: model)
    }
}

extension ContainerViewController {
    func initTableView() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.register(UINib(nibName: viewModel.cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.cellReuseIdentifier)
    }
}

extension ContainerViewController : ContainerViewControllerViewModelProtocol {
    func initViewModel() {
        viewModel.delegate = self
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    func error(text: String) {
        showText(text)
    }
}
