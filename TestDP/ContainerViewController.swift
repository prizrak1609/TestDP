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
    fileprivate let refreshControll = UIRefreshControl()

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

    func reloadInfoWithoutCache() {
        viewModel.loadInfo(cached: false, model: model)
        refreshControll.endRefreshing()
    }
}

extension ContainerViewController {
    func initTableView() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        refreshControll.addTarget(self, action: #selector(reloadInfoWithoutCache), for: .valueChanged)
        tableView.refreshControl = refreshControll
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
