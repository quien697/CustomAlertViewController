//
//  ActionButton2.swift
//  CustomAlertViewController
//
//  Created by Quien on 2023/7/5.
//

import UIKit

class ActionButton2: UIButton {
  
  private var actionHandler: (() -> Void)!
  
  init(withAction action: Action) {
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.actionHandler = action.actionHandler
    self.setUpButtonWith(action: action)
  }
  
  private func setUpButtonWith(action: Action) {
    self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    self.setTitle(action.title, for: .normal)
    self.layer.cornerRadius = 5
    addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
    self.setUpUIForStyle(style: action.style)
  }
  
  private func setUpUIForStyle(style: ActionStyle) {
    self.backgroundColor = style.backgroundColor
    self.setTitleColor(style.titleColor, for: .normal)
    self.setTitleColor(style.highlightedTitleColor, for: .highlighted)
  }
  
  @objc func didTapButton() {
    self.actionHandler?()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
