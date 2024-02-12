//
//  AboutAppAssembler.swift
//  MdEditor
//
//  Created by Руслан Мингалиев on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import FileManagerPackage

final class AboutAppAssembler {

	// MARK: - Dependencies

	private let fileExplorer: IFileExplorer

	// MARK: - Initialization

	/// Инициализатор сборщика основного модуля.
	/// - Parameters:
	///   - taskManager: репозиторий файлов .
	init(fileExplorer: IFileExplorer) {
		self.fileExplorer = fileExplorer
	}

	// MARK: - Public methods

	/// Сборка модуля о приложении.
	/// - Returns: view
	func assembly() -> AboutAppViewController {
		let viewController = AboutAppViewController()
		let presenter = AboutAppPresenter(viewController: viewController)
		let interactor = AboutAppInteractor(presenter: presenter, fileExplorer: fileExplorer)
		viewController.interactor = interactor

		return viewController
	}
}
