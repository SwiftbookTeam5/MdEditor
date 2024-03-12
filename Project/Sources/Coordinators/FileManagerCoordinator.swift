//
//  OpenFileCoordinator.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import FileManagerPackage
import MarkdownParserPackage

final class FileManagerCoordinator: NSObject, ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private var topViewController: UIViewController?
	private let converter: IMarkdownToAttributedTextConverter
	private let converterToExport: IMarkdownConverterAdapter

	// MARK: - Internal properties

	var finishFlow: (() -> Void)?

	// MARK: - Initialization

	init(
		navigationController: UINavigationController,
		topViewController: UIViewController?,
		converter: IMarkdownToAttributedTextConverter,
		converterToExport: IMarkdownConverterAdapter
	) {
		self.navigationController = navigationController
		self.topViewController = topViewController
		self.converter = converter
		self.converterToExport = converterToExport

		super.init()

		navigationController.delegate = self
	}

	// MARK: - Internal methods

	func start() {
		showFileManagerScene(file: nil)
	}
}

// MARK: - Private methods

private extension FileManagerCoordinator {

	func showMessage(message: String) {
		let alert = UIAlertController(title: L10n.Message.text, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: L10n.Ok.text, style: .default)
		alert.addAction(action)

		navigationController.present(alert, animated: true, completion: nil)
	}

	func showFileManagerScene(file: File?) {
		let viewController = FileManagerAssembler().assembly(
			fileExplorer: FileExplorer(),
			delegate: self,
			file: file
		)

		navigationController.pushViewController(viewController, animated: true)
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
}

// MARK: - UINavigationControllerDelegate

extension FileManagerCoordinator: UINavigationControllerDelegate {

	func navigationController(
		_ navigationController: UINavigationController,
		didShow viewController: UIViewController,
		animated: Bool
	) {
		if viewController === topViewController {
			finishFlow?()
		}
	}
}

// MARK: - IFileManagerDelegate

extension FileManagerCoordinator: IFileManagerDelegate {

	func openFolder(file: File) {
		showFileManagerScene(file: file)
	}

	func openFile(file: File) {
		showTextPreviewScene(file: file)
	}
}

// MARK: - ITextPreviewDelegate

extension FileManagerCoordinator: ITextPreviewDelegate {

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
