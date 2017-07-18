//
//  ContainerViewControllerViewModel.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

protocol ContainerViewControllerViewModelProtocol : class {
    func reloadTableView()
}

final class ContainerViewControllerViewModel : NSObject {
    fileprivate var models = [CurrencyInfoModel]()

    let cellReuseIdentifier = "CurrencyInfoCell"
    weak var delegate: ContainerViewControllerViewModelProtocol?

    func loadInfo(using model: CurrencyModel?) {
        guard let model = model else { return }
        // TODO: load info from server
        delegate?.reloadTableView()
    }
}

extension ContainerViewControllerViewModel : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? CurrencyInfoCell else { return UITableViewCell() }
        cell.model = models[indexPath.row]
        return cell
    }
}
