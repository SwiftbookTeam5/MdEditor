//
//  OpenFileAssembler.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import FileManagerPackage

final class OpenFileAssembler {

	// MARK: - Dependencies

	private let fileExplorer: IFileExplorer

	// MARK: - Initialization

	/// Инициализатор сборщика основного модуля.
	/// - Parameters:
	///   - taskManager: репозиторий файлов .
	init(fileExplorer: IFileExplorer) {
		self.fileExplorer = fileExplorer
	}

	// MARK: - Internal methods

	/// Сборка модуля стартового экрана.
	/// - Returns: контроллер с проставленными зависимостями VIP цикла.
	func assembly(url: URL?, openFileResultClosure: OpenFileResultClosure?) -> OpenFileViewController {
		let viewController = OpenFileViewController()
		let presenter = OpenFilePresenter(viewController: viewController, openFileResultClosure: openFileResultClosure)
		let interactor = OpenFileInteractor(presenter: presenter, fileExplorer: fileExplorer, url: url)
		viewController.interactor = interactor

		return viewController
	}
}
