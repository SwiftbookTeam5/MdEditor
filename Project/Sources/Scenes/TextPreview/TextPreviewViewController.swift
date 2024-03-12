//
//  TextPreviewViewController.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import UIKit

protocol ITextPreviewViewController: AnyObject {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: TextPreviewModel.ViewModel)
}

/// TextPreviewViewController
final class TextPreviewViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: ITextPreviewInteractor?

	// MARK: - Private properties

	private var viewModel: TextPreviewModel.ViewModel! // swiftlint:disable:this implicitly_unwrapped_optional

	private lazy var textView = makeLabel(
		accessibilityIdentifier: AccessibilityIdentifier.TextPreviewScene.textView.description
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

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		layout()
	}

	// MARK: - Actions

	@objc
	private func didTapExportPDF() {
		interactor?.exportToPDF()
	}
}

// MARK: - Setup UI

private extension TextPreviewViewController {

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor

		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "square.and.arrow.up")?.withTintColor(Theme.mainColor, renderingMode: .alwaysOriginal),
			style: .plain,
			target: self,
			action: #selector(didTapExportPDF)
		)

		view.addSubview(textView)
	}

	func makeLabel(accessibilityIdentifier: String) -> UITextView {
		let textView = UITextView()
		textView.font = UIFont.boldSystemFont(ofSize: 17)
		textView.textColor = Theme.mainColor
		textView.backgroundColor = Theme.backgroundColor
		textView.textAlignment = .left
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.accessibilityIdentifier = accessibilityIdentifier

		return textView
	}
}

// MARK: - Layout UI

private extension TextPreviewViewController {

	func layout() {
		NSLayoutConstraint.deactivate(constraints)

		let newConstraints = [
			textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Sizes.Padding.normal),
			textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),
			textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Sizes.Padding.normal)
		]

		NSLayoutConstraint.activate(newConstraints)

		constraints = newConstraints
	}
}

// MARK: - ITextPreviewViewController

extension TextPreviewViewController: ITextPreviewViewController {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: TextPreviewModel.ViewModel) {
		self.viewModel = viewModel
		title = viewModel.currentTitle
		textView.isScrollEnabled = false
		textView.attributedText = viewModel.text
		textView.isScrollEnabled = true
	}
}
