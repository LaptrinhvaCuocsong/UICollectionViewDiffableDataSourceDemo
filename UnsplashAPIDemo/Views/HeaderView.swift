//
//  HeaderView.swift
//  UnsplashAPIDemo
//
//  Created by Apple on 4/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var btnOther: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Other", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup() {
        addSubview(lblTitle)
        lblTitle.addConstraint(leading: leadingAnchor, leadingConstant: 10,
                               centerY: centerYAnchor)
        addSubview(btnOther)
        btnOther.addConstraint(trailing: trailingAnchor, trailingConstant: -10,
                               centerY: centerYAnchor)
    }
}
