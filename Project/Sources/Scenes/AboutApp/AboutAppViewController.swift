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
	private lazy var textViewAboutApp: UITextView = makeTextView(
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

	func makeTextView(accessibilityIdentifier: String) -> UITextView {
		let textView = UITextView()

		textView.backgroundColor = Theme.backgroundColor
		textView.textColor = Theme.mainColor
		textView.layer.borderWidth = Sizes.borderWidth
		textView.layer.cornerRadius = Sizes.cornerRadius
		textView.layer.borderColor = Theme.borderPlaceholderColor.cgColor
		textView.accessibilityIdentifier = accessibilityIdentifier

		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = UIFont.preferredFont(forTextStyle: .body)
		textView.adjustsFontForContentSizeCategory = true

		return textView
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
				textViewAboutApp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				textViewAboutApp.topAnchor.constraint(equalTo: view.topAnchor, constant: thirdOfTheScreen),
				textViewAboutApp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
				textViewAboutApp.heightAnchor.constraint(equalToConstant: Sizes.L.height)
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

	func render(viewModel: AboutAppModel.ViewModel) {
		textViewAboutApp.text = viewModel.textAbout
	}
}
