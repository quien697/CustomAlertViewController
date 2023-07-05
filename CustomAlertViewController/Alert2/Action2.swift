//
//  Action2.swift
//  CustomAlertViewController
//
//  Created by Quien on 2023/7/5.
//

import Foundation
import UIKit

enum ActionStyle {
  case normal
  case destructive
  case destructiveDark
  case normalDark
  
  var titleColor: UIColor {
    switch self {
    case .destructive, .destructiveDark, .normalDark:
      return UIColor.white
    case .normal:
      return UIColor.black
    }
  }
  
  var backgroundColor: UIColor {
    switch self {
    case .normal:
      return UIColor.darkGray.withAlphaComponent(0.5)
    case .destructive, .destructiveDark:
      return UIColor.red
    case .normalDark:
      return UIColor.lightGray
    }
  }
  
  var highlightedTitleColor: UIColor {
    switch self {
    case .normal, .destructive,.destructiveDark,.normalDark :
      return self.titleColor.withAlphaComponent(0.6)
    }
  }
}

class Action {
  var title: String
  var style: ActionStyle
  var actionHandler: () -> Void
  
  init(with title: String, style: ActionStyle = .normal, actionHandler: @escaping () -> Void) {
    self.title = title
    self.style = style
    self.actionHandler = actionHandler
  }
}
