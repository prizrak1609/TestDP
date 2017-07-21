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
    func error(text: String)
}

final class ContainerViewControllerViewModel : NSObject {
    fileprivate var models = [CurrencyInfoModel]()
    fileprivate let server = Server()

    let cellReuseIdentifier = "CurrencyInfoCell"
    weak var delegate: ContainerViewControllerViewModelProtocol?

    func loadInfo(cached: Bool = true, model: CurrencyModel?) {
        guard let model = model else { return }
        server.getRateInfo(cached: cached, rate: model) { [weak self] result in
            guard let welf = self else { return }
            switch result {
                case .error(let text): welf.delegate?.error(text: text)
                case .success(let models):
                    welf.models = models
                    welf.delegate?.reloadTableView()
            }
        }
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
