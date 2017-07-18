//
//  Storyboards.swift
//  TestMK
//
//  Created by Dima Gubatenko on 13.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

enum Storyboards {

    enum Name {
        static let currencyList = "CurrencyListScreen"
        static let currencyExchange = "CurrencyExchangeScreen"
    }

    static var currencyList: UIViewController? {
        return UIStoryboard(name: Name.currencyList, bundle: nil).instantiateInitialViewController()
    }

    static var currencyExchange: UIViewController? {
        return UIStoryboard(name: Name.currencyExchange, bundle: nil).instantiateInitialViewController()
    }
}
