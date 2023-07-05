//
//  AlertViewController.swift
//  CustomAlertViewController
//
//  Created by Quien on 2023/7/4.
//

import UIKit

class AlertViewController: UIViewController {
  
  private let spacing: CGFloat = 16.0
  private let titleText: String
  private let contentText: String
  private var axis: NSLayoutConstraint.Axis = .horizontal
  private let confirmButtonTitle: String
  private let cancelButtonTitle: String
  private let confirmAction: (() -> Void)?
  private let cancelAction: (() -> Void)?
  
  private lazy var backdropView: UIView = {
    let view = createView(with: UIColor.black.withAlphaComponent(0.0))
    return view
  }()
  
  private lazy var containerView: UIView = {
    let view = createView(with: .white)
    view.layer.cornerRadius = 12.0
    return view
  }()
  
  private lazy var dividerView: UIView = {
    let view = createView(with: .black)
    return view
  }()
  
  private lazy var titleStackView: UIStackView = {
    let stackView = createStackView(axis: .vertical, spacing: 5.0)
    stackView.distribution = .fillProportionally
    return stackView
  }()
  
  private lazy var actionsStackView: UIStackView = {
    let stackView = createStackView(axis: self.axis, spacing: 10.0)
    return stackView
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = createLabel(textColor: .black, font: UIFont.boldSystemFont(ofSize: 16.0))
    return label
  }()
  
  private lazy var contentLabel: UILabel = {
    let label = createLabel(textColor: .black, font: UIFont.systemFont(ofSize: 14.0))
    return label
  }()
  
  private lazy var confirmButton: UIButton = {
    let button = createButton(textColor: .white, backgroundColor: .systemGreen, style: .filled())
    button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var cancelButton: UIButton = {
    let button = createButton(textColor: .white, backgroundColor: .systemRed, style: .filled())
    button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    return button
  }()
  
  init(title: String, content: String, axis: NSLayoutConstraint.Axis, confirmButtonTitle: String, cancelButtonTitle: String, confirmAction: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil) {
    self.titleText = title
    self.contentText = content
    self.axis = axis
    self.confirmButtonTitle = confirmButtonTitle
    self.cancelButtonTitle = cancelButtonTitle
    self.confirmAction = confirmAction
    self.cancelAction = cancelAction
    super.init(nibName: nil, bundle: nil)
    
    modalPresentationStyle = .overCurrentContext
    modalTransitionStyle = .crossDissolve
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupAnimation()
  }
  
  private func setupUI() {
    view.addSubview(backdropView)
    view.addSubview(containerView)
    containerView.addSubview(titleStackView)
    containerView.addSubview(dividerView)
    containerView.addSubview(actionsStackView)
    // MARK: setup label
    titleLabel.text = titleText
    contentLabel.text = contentText
    titleStackView.addArrangedSubview(titleLabel)
    titleStackView.addArrangedSubview(contentLabel)
    // MARK: setup button
    confirmButton.configuration?.title = confirmButtonTitle
    cancelButton.configuration?.title = cancelButtonTitle
    actionsStackView.axis = axis
    actionsStackView.addArrangedSubview(confirmButton)
    actionsStackView.addArrangedSubview(cancelButton)
    
    NSLayoutConstraint.activate([
      backdropView.topAnchor.constraint(equalTo: view.topAnchor),
      backdropView.leftAnchor.constraint(equalTo: view.leftAnchor),
      backdropView.rightAnchor.constraint(equalTo: view.rightAnchor),
      backdropView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
      
      titleStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: spacing),
      titleStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: spacing),
      titleStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -spacing),
      
      dividerView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: spacing),
      dividerView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
      dividerView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
      dividerView.heightAnchor.constraint(equalToConstant: 1),
      
      actionsStackView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: spacing),
      actionsStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: spacing),
      actionsStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -spacing),
      actionsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -spacing),
    ])
  }
  
  // MARK: Button Actions
  
  @objc private func confirmButtonTapped() {
    confirmAction?()
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func cancelButtonTapped() {
    cancelAction?()
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: Animation functions
  
  private func setupAnimation() {
    containerView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    perform(#selector(animateAlert), with: self, afterDelay: 0.2)
  }
  
  @objc private func animateAlert() {
    backdropView.alpha = 0.0
    UIView.animate(withDuration: 0.1, animations: {
      self.backdropView.alpha = 1.0
      self.backdropView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
      self.containerView.transform = .identity
    })
  }
  
  // MARK: Convenience functions
  
  private func createStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 1) -> UIStackView {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = axis
    stackView.spacing = spacing
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    return stackView
  }
  
  private func createView(with backgroundColor: UIColor = UIColor.white, cornerRadius: CGFloat = 0.0) -> UIView {
    let newView = UIView()
    newView.translatesAutoresizingMaskIntoConstraints = false
    newView.backgroundColor = backgroundColor
    newView.layer.cornerRadius = cornerRadius
    return newView
  }
  
  private func createLabel(textColor: UIColor, font: UIFont) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = textColor
    label.textAlignment = .center
    label.font = font
    label.numberOfLines = 0
    return label
  }
  
  private func createButton(textColor: UIColor, backgroundColor: UIColor, style: UIButton.Configuration) -> UIButton {
    var config = style
    config.cornerStyle = .capsule
    config.baseForegroundColor = textColor
    config.baseBackgroundColor = backgroundColor
    
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.configuration = config
    return button
  }
  
}
