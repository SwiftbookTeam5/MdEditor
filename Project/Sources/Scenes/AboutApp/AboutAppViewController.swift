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

	private lazy var textViewAboutApp: UITextView = makeTextView(
		accessibilityIdentifier: AccessibilityIdentifier.AboutApp.textFieldAboutApp.description
	)

	private var constraints = [NSLayoutConstraint]()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		interactor?.fetchData()
	}
}

// MARK: - Setup UI

private extension AboutAppViewController {

	func makeTextView(accessibilityIdentifier: String) -> UITextView {
		let textView = UITextView()

		textView.backgroundColor = Theme.backgroundColor
		textView.textColor = Theme.mainColor
		textView.layer.borderWidth = Sizes.borderWidth
		textView.layer.cornerRadius = Sizes.Radius.small
		textView.layer.borderColor = Theme.borderPlaceholderColor.cgColor
		textView.accessibilityIdentifier = accessibilityIdentifier

		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = UIFont.preferredFont(forTextStyle: .body)
		textView.adjustsFontForContentSizeCategory = true

		return textView
	}

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		navigationItem.largeTitleDisplayMode = .never

		title = L10n.About.title
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.titleTextAttributes = [
			NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)
		]

		view.addSubview(textViewAboutApp)
		layout()
	}
}

// MARK: - Layout UI

private extension AboutAppViewController {

	func layout() {
		let newConstraints = [
			textViewAboutApp.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: Sizes.Padding.normal
			),
			textViewAboutApp.leadingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.leadingAnchor,
				constant: Sizes.Padding.normal
			),
			textViewAboutApp.trailingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.trailingAnchor,
				constant: -Sizes.Padding.normal
			),
			textViewAboutApp.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: -Sizes.Padding.normal
			)
		]

		NSLayoutConstraint.activate(newConstraints)
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
