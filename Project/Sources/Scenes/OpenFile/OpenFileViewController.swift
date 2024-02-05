//
//  OpenFileViewController.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

/// Протокол главного экрана приложения.
protocol IOpenFileViewController: AnyObject {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: OpenFileModel.ViewModel)
}

/// Главный экран приложения.
final class OpenFileViewController: UITableViewController {

	// MARK: - Dependencies

	var interactor: IOpenFileInteractor?

	// MARK: - Private properties

	private var viewModel = OpenFileModel.ViewModel(files: [])

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

// MARK: - UITableView

extension OpenFileViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.files.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

		cell.accessibilityIdentifier = AccessibilityIdentifier.TodoList.cell(
			section: indexPath.section,
			index: indexPath.row
		).description

		configureCell(cell, with: viewModel.files[indexPath.row])

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didFileSelected(request: OpenFileModel.Request.ItemSelected(indexPath: indexPath))
	}
}

// MARK: - UI setup

private extension OpenFileViewController {

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		navigationItem.largeTitleDisplayMode = .never

		title = L10n.File.title

		tableView.accessibilityIdentifier = AccessibilityIdentifier.TodoList.tableView.description
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func configureCell(_ cell: UITableViewCell, with file: OpenFileModel.ViewModel.File) {
		cell.tintColor = Theme.accentColor
		cell.selectionStyle = .none

		var contentConfiguration = cell.defaultContentConfiguration()
		contentConfiguration.image = file.image

		contentConfiguration.text = file.title
		contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: .body)
		contentConfiguration.textProperties.adjustsFontForContentSizeCategory = true

		contentConfiguration.secondaryText = file.subTitle
		contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption2)
		contentConfiguration.secondaryTextProperties.adjustsFontForContentSizeCategory = true

		cell.contentConfiguration = contentConfiguration
	}
}

// MARK: - IMainViewController

extension OpenFileViewController: IOpenFileViewController {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: OpenFileModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
