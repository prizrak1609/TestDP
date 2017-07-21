//
//  ScrollView.swift
//  TestDP
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

protocol ScrollViewDelegate : class {
    func scrollViewSelected(model: CurrencyModel, and view: UIView, in scrollView: ScrollView)
}

protocol ScrollViewDataSource : class {
    func scrollViewGetViewSize(in scrollView: ScrollView) -> CGSize
    func scrollViewGetView(from index: Int, with model: CurrencyModel, in scrollView: ScrollView) -> UIView
}

final class ScrollView: UIScrollView {

    weak var customDelegate: ScrollViewDelegate?
    weak var customDataSource: ScrollViewDataSource?

    private var models = [CurrencyModel]()
    private var viewSize = CGSize.zero

    func addModel(_ model: CurrencyModel) {
        guard let dataSource = customDataSource else { return }
        viewSize = dataSource.scrollViewGetViewSize(in: self)
        let view = dataSource.scrollViewGetView(from: subviews.count - 1, with: model, in: self)
        var size = contentSize
        size.width += viewSize.width
        contentSize = size
        addSubview(view)
        models.append(model)
    }

    func addModels(_ models: [CurrencyModel]) {
        models.forEach(addModel)
    }

    func scrollTo(_ model: CurrencyModel) {
        guard let index = models.index(where: { $0.name == model.name }) else { return }
        let positionX = viewSize.width * CGFloat(index)
        let point = CGPoint(x: positionX, y: 0)
        contentOffset = point
        customDelegate?.scrollViewSelected(model: model, and: subviews[index], in: self)
    }

    override func layoutSubviews() {
        var point = CGPoint.zero
        for (index, view) in subviews.enumerated() {
            point.x = viewSize.width * CGFloat(index)
            view.frame.origin = point
            view.frame.size = viewSize
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = Array(touches).last else { return }
        let location = touch.location(in: self)
        let index = Int(floor(location.x / viewSize.width))
        customDelegate?.scrollViewSelected(model: models[index], and: subviews[index], in: self)
    }
}
