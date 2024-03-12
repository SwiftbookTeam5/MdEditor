//
//  MainCoordinator.swift
//  MdEditor
//
//  Created by Александра Рязанова on 01.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import FileManagerPackage
import MarkdownParserPackage

final class MainCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let converter = MarkdownToAttributedTextConverter()
	private let converterToExport = MarkdownConverterAdapter()

	// MARK: - Initialization

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	override func start() {
		showMainScene()
	}
}

// MARK: - Private methods

private extension MainCoordinator {

	func showMessage(message: String) {
		let alert = UIAlertController(title: L10n.Message.text, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: L10n.Ok.text, style: .default)
		alert.addAction(action)

		navigationController.present(alert, animated: true, completion: nil)
	}

	func showMainScene() {
		let assembler = MainAssembler()
		let recentFileManager = StubRecentFileManager()
		let viewController = assembler.assembly(recentFileManager: recentFileManager, delegate: self)

		navigationController.setViewControllers([viewController], animated: true)
	}

	func showTextPreviewScene(file: File) {
		let viewController = TextPreviewAssembler().assembly(
			file: file,
			converter: converter,
			converterToExport: converterToExport,
			delegate: self
		)
		navigationController.pushViewController(viewController, animated: true)
	}

	func runFileManagerFlow() {
		let topViewController = navigationController.topViewController
		let coordinator = FileManagerCoordinator(
			navigationController: navigationController,
			topViewController: topViewController,
			converter: converter,
			converterToExport: converterToExport
		)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			guard let self = self, let coordinator = coordinator else { return }
			self.removeDependency(coordinator)
			if let topViewController = topViewController {
				self.navigationController.popToViewController(topViewController, animated: true)
			} else {
				self.navigationController.viewControllers.removeAll()
			}
		}

		addDependency(coordinator)
		coordinator.start()
	}
}

// MARK: - IMainMenuDelegate

extension MainCoordinator: IMainDelegate {

	func showAbout() {
		switch File.parse(url: Endpoints.documentAbout) {
		case .success(let aboutFile):
			showTextPreviewScene(file: aboutFile)
		case .failure:
			break
		}
	}

	func openFileExplorer() {
		runFileManagerFlow()
	}

	func newFile() {
		showMessage(message: L10n.Feature.newFile)
	}

	func openFile(file: File) {
		showTextPreviewScene(file: file)
	}
}

// MARK: - ITextPreviewDelegate

extension MainCoordinator: ITextPreviewDelegate {

	/// Открытие окна выбора пути для экспорта файла.
	/// - Parameter url: url файла источника.
	func saveFile(sourceURL: URL) {
		let documentPicker = UIDocumentPickerViewController(forExporting: [sourceURL], asCopy: true)
		navigationController.present(documentPicker, animated: true)
	}

	/// Отображение ошибки
	/// - Parameter message: сообщение
	func showError(message: String) {
		showMessage(message: message)
	}
}
