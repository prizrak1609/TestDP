//
//  ScrollView.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

protocol ScrollViewDelegate : class {
    func scrollViewSelected(model: CurrencyModel, in scrollView: ScrollView)
}

final class ScrollView: UIScrollView {

    var buttonsSize = CGSize(width: 40, height: 40)
    weak var customDelegate: ScrollViewDelegate?

    private var models = [CurrencyModel]()

    func addModel(_ model: CurrencyModel) {
        let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: buttonsSize))
        label.textAlignment = .center
        label.text = model.name
        addSubview(label)
        models.append(model)
    }

    func addModels(_ models: [CurrencyModel]) {
        models.forEach { addModel($0) }
    }

    override func layoutSubviews() {
        var point = CGPoint.zero
        for (index, view) in subviews.enumerated() {
            point.x = buttonsSize.width * CGFloat(index)
            view.frame.origin = point
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = Array(touches).last else { return }
        let location = touch.location(in: self)
        let index = Int(floor(location.x / buttonsSize.width))
        customDelegate?.scrollViewSelected(model: models[index], in: self)
    }
}
