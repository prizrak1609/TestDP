//
//  CurrencyExchangeScreenViewModel.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

protocol CurrencyExchangeScreenViewModelProtocol : class {
    func error(text: String)
}

final class CurrencyExchangeScreenViewModel {

    fileprivate let server = Server()

    weak var delegate: CurrencyExchangeScreenViewModelProtocol?

    func loadInfo(completion: @escaping ([CurrencyModel]) -> Void) {
        server.getRates { [weak self] result in
            guard let welf = self else { return }
            switch result {
                case .error(let text): welf.delegate?.error(text: text)
                case .success(let models): completion(models)
            }
        }
    }
}
