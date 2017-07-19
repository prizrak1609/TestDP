//
//  CurrencyListScreenViewModel.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

protocol CurrencyListScreenViewModelProtocol : class {
    func didSelectRow(_ indexPath: IndexPath, with model: CurrencyModel)
    func reloadTableView()
    func error(text: String)
}

final class CurrencyListScreenViewModel : NSObject {

    fileprivate var models = [CurrencyModel]()
    fileprivate var showedModels = [CurrencyModel]()
    fileprivate let server = Server()

    let cellReuseIdentifier = "CurrencyListCell"
    weak var delegate: CurrencyListScreenViewModelProtocol?

    func loadData() {
        server.getRates { [weak self] result in
            guard let welf = self else { return }
            switch result {
                case .error(let text): welf.delegate?.error(text: text)
                case .success(let models):
                    welf.models = models
                    welf.showedModels = models
                    welf.delegate?.reloadTableView()
            }
        }
    }
}

extension CurrencyListScreenViewModel : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showedModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? CurrencyListCell else { return UITableViewCell() }
        cell.model = showedModels[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(indexPath, with: showedModels[indexPath.row])
    }
}

extension CurrencyListScreenViewModel : UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            showedModels = models.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        } else {
            showedModels = models
        }
        delegate?.reloadTableView()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        showedModels = models
        delegate?.reloadTableView()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}
