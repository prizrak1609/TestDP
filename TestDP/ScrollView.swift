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

    var buttonsWidth: CGFloat = 40
    weak var customDelegate: ScrollViewDelegate?

    private var models = [CurrencyModel]()

    func addModel(_ model: CurrencyModel) {
        let buttonsSize = CGSize(width: buttonsWidth, height: bounds.height)
        let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: buttonsSize))
        label.textAlignment = .center
        label.text = model.name
        addSubview(label)
        var size = contentSize
        size.width += label.frame.width
        contentSize = size
        models.append(model)
    }

    func addModels(_ models: [CurrencyModel]) {
        models.forEach { addModel($0) }
    }

    func scrollTo(_ model: CurrencyModel) {
        guard let index = models.index(where: { $0.name == model.name }) else { return }
        let positionX = buttonsWidth * CGFloat(index)
        let point = CGPoint(x: positionX, y: 0)
        contentOffset = point
        customDelegate?.scrollViewSelected(model: model, in: self)
    }

    override func layoutSubviews() {
        var point = CGPoint.zero
        for (index, view) in subviews.enumerated() {
            point.x = view.frame.width * CGFloat(index)
            view.frame.origin = point
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = Array(touches).last else { return }
        let location = touch.location(in: self)
        let index = Int(floor(location.x / buttonsWidth))
        customDelegate?.scrollViewSelected(model: models[index], in: self)
    }
}
