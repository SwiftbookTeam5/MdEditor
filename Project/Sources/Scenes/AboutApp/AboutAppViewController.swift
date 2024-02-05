//
//  AboutAppViewController.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

protocol IAboutAppViewController: AnyObject {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: AboutAppModel.ViewModel)
}

final class AboutAppViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IAboutAppInteractor?

	// MARK: - Private properties
	// FIXME:  На данный момент только одно поле, т.к не понятно какие поля необходимы
	private lazy var textFieldAboutApp: UITextField = makeTextField(
		accessibilityIdentifier: AccessibilityIdentifier.AboutApp.textFieldAboutApp.description
	)

	private var constraints = [NSLayoutConstraint]()

	// MARK: - Initialization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
}

// MARK: - Setup UI

private extension AboutAppViewController {

	func makeTextField(accessibilityIdentifier: String) -> UITextField {
		let textField = UITextField()

		textField.backgroundColor = Theme.backgroundColor
		textField.textColor = Theme.mainColor
		textField.layer.borderWidth = Sizes.borderWidth
		textField.layer.cornerRadius = Sizes.cornerRadius
		textField.layer.borderColor = Theme.borderPlaceholderColor.cgColor
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Sizes.Padding.half, height: textField.frame.height))
		textField.leftViewMode = .always
		textField.accessibilityIdentifier = accessibilityIdentifier

		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.font = UIFont.preferredFont(forTextStyle: .body)
		textField.adjustsFontForContentSizeCategory = true

		return textField
	}

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.Auth.title
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.titleTextAttributes = [
			NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)
		]
	}
}

// MARK: - Layout UI

private extension AboutAppViewController {

		func layout() {
			NSLayoutConstraint.deactivate(constraints)

			let newConstraints = [
				textFieldAboutApp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				textFieldAboutApp.topAnchor.constraint(equalTo: view.topAnchor, constant: thirdOfTheScreen),
				textFieldAboutApp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
				textFieldAboutApp.heightAnchor.constraint(equalToConstant: Sizes.L.height)
			]

			NSLayoutConstraint.activate(newConstraints)

			constraints = newConstraints
		}

		var thirdOfTheScreen: Double {
			return view.bounds.size.height / 3.0
		}
}

// MARK: - IAboutAppViewController

extension AboutAppViewController: IAboutAppViewController {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	//FIXME: Как будет понимание по модели, необходимо реализовать функцию
	func render(viewModel: AboutAppModel.ViewModel) {
	}
}
