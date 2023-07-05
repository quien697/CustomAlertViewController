//
//  ViewController.swift
//  CustomAlertViewController
//
//  Created by Quien on 2023/7/4.
//

import UIKit

class ViewController: UIViewController {
  
  let button: UIButton = {
    let btn = UIButton(type: .system)
    btn.configuration = .filled()
    btn.setTitle("Show Alert", for: .normal)
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupButton()
  }
  
  func setupButton() {
    view.addSubview(button)
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
  
  @objc func buttonTapped() {
//    showAlert1()
    showAlert2()
  }
  
  func showAlert1() {
    let ac = AlertViewController(
      title: "Are you sure?",
      content: "Are you sure want to sent a message?",
      axis: .horizontal,
      confirmButtonTitle: "OK",
      cancelButtonTitle: "Cancel",
      confirmAction: {
        print("tapped confirm button")
      },
      cancelAction: {
        print("tapped cancel button")
      })
    
    present(ac, animated: true, completion: nil)
  }
  
  func showAlert2() {
    
    let cancelAction = Action(with: "Cancel", style: .normal) {[weak self] in
        print("Cancel pressed")
        self?.dismiss(animated: true, completion: nil)
    }
    
    let deleteAction = Action(with: "Delete", style: .destructive) {[weak self] in
        print("Delete pressed")
        self?.dismiss(animated: true, completion: nil)
    }
    
    let ac = AlertViewController2(
      title: "Are you sure?",
      content: "Are you sure want to sent a message?",
      axis: .vertical,
      style: .dark,
      actions: [cancelAction, deleteAction])
    
    present(ac, animated: true, completion: nil)
  }
  
}

