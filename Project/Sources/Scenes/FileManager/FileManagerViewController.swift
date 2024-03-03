//
//  FileManagerViewController.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

/// Протокол главного экрана приложения.
protocol IFileManagerViewController: AnyObject {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: FileManagerModel.ViewModel)
}

/// Главный экран приложения.
final class FileManagerViewController: UITableViewController {

	// MARK: - Dependencies

	var interactor: IFileManagerInteractor?

	// MARK: - Private properties

	private var viewModel = FileManagerModel.ViewModel(currentFolderName: L10n.File.title, files: [])

	private lazy var folderImage = makeFolderImage()
	private lazy var fileImage = makeFileImage()

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

extension FileManagerViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.files.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: FileTableViewCell.reusableIdentifier,
			for: indexPath
		) as! FileTableViewCell // swiftlint:disable:this force_cast

		cell.accessibilityIdentifier = AccessibilityIdentifier.FileManager.cell(
			section: indexPath.section,
			index: indexPath.row
		).description

		let file = viewModel.files[indexPath.row]
		switch file.isFolder {
		case true:
			cell.configure(title: file.name, subtitle: file.info, icon: folderImage)
		case false:
			cell.configure(title: file.name, subtitle: file.info, icon: fileImage)
		}

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.performAction(request: .fileSelected(indexPath: indexPath))
	}
}

// MARK: - UI setup

private extension FileManagerViewController {

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		navigationItem.largeTitleDisplayMode = .never

		title = viewModel.currentFolderName

		tableView.accessibilityIdentifier = AccessibilityIdentifier.TodoList.tableView.description
		tableView.register(FileTableViewCell.self, forCellReuseIdentifier: FileTableViewCell.reusableIdentifier)
	}

	func makeFolderImage() -> UIImage {
		Asset.Icons.folder.image.withTintColor(
			Theme.mainColor,
			renderingMode: .alwaysOriginal
		)
	}

	func makeFileImage() -> UIImage {
		Asset.Icons.textFile.image.withTintColor(
			Theme.mainColor,
			renderingMode: .alwaysOriginal
		)
	}
}

// MARK: - IMainViewController

extension FileManagerViewController: IFileManagerViewController {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: FileManagerModel.ViewModel) {
		self.viewModel = viewModel
		title = viewModel.currentFolderName
		tableView.reloadData()
	}
}
