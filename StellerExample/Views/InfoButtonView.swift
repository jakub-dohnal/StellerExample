//
//  InfoButtonView.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 19/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

final class InfoButtonView: UIView {

    var labelText: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }

    var buttonText: String? {
        get {
            return button.title(for: .normal)
        }
        set {
            button.setTitle(newValue, for: .normal)
        }
    }

    var buttonPressAction: (() -> Void)?

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let button = UIButton(type: .system)

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(frame: .zero)
        setup()
    }

    private func setup() {
        let stackView = UIStackView(arrangedSubviews: [label, button])
        stackView.axis = .vertical
        stackView.spacing = 10

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc
    private func buttonTapped() {
        buttonPressAction?()
    }
}
