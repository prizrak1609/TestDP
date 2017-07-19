//
//  Server.swift
//  TestDP
//
//  Created by Dima Gubatenko on 19.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class Server {
    private let baseAddress = "http://api.fixer.io"

    private lazy var cachedManager: Alamofire.SessionManager = {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let memoryCapacity = 2048 // bytes
        urlSessionConfiguration.urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: 0, diskPath: nil)
        let manager = Alamofire.SessionManager(configuration: urlSessionConfiguration)
        return manager
    }()

    func getRates(cached: Bool = true, _ completion: @escaping (Result<[CurrencyModel]>) -> Void) {
        guard let url = URL(string: "\(baseAddress)/latest") else {
            completion(.error(NSLocalizedString("can't create URL from \(baseAddress)/latest", comment: "Server getRates")))
            return
        }
        if !cached {
            clearCache()
        }
        cachedManager.request(url, method: .get).responseJSON { [weak self] response in
            guard let welf = self else { return }
            let result = welf.parseJSON(response: response)
            if case .error(let text) = result {
                completion(.error(text))
                return
            }
            if case .success(let json) = result {
                let rates = Array(json["rates"].dictionaryValue.keys.map({ CurrencyModel(name: $0) }))
                completion(.success(rates))
            }
        }
    }

    func getRateInfo(cached: Bool = true, rate: CurrencyModel, _ completion: @escaping (Result<[CurrencyInfoModel]>) -> Void) {
        guard let url = URL(string: "\(baseAddress)/latest") else {
            completion(.error(NSLocalizedString("can't create URL from \(baseAddress)/latest", comment: "Server getRates")))
            return
        }
        if !cached {
            clearCache()
        }
        let params = ["base": rate.name]
        cachedManager.request(url, method: .get, parameters: params).responseJSON { [weak self] response in
            guard let welf = self else { return }
            let result = welf.parseJSON(response: response)
            if case .error(let text) = result {
                completion(.error(text))
                return
            }
            if case .success(let json) = result {
                let ratesInfo = json["rates"].dictionaryValue.map { key, value in
                    return CurrencyInfoModel(from: rate.name, to: key, value: value.floatValue)
                }
                completion(.success(ratesInfo))
            }
        }
    }

    private func clearCache() {
        URLCache.shared.removeAllCachedResponses()
    }

    private func parseJSON(response: DataResponse<Any>) -> Result<JSON> {
        if let error = response.error ?? response.result.error {
            return .error(error.localizedDescription)
        }
        if let result = response.result.value {
            return .success(JSON(result))
        }
        return .error(NSLocalizedString("Can't get response", comment: "Server parseJSON"))
    }
}
