//
//  MainAssembler.swift
//  MdEditor
//
//  Created by Александра Рязанова on 01.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

final class MainAssembler {

	// MARK: - Dependencies

	private let fileRepository: IFileRepository

	// MARK: - Initialization

	/// Инициализатор сборщика основного модуля.
	/// - Parameters:
	///   - taskManager: репозиторий файлов .
	init(fileRepository: IFileRepository) {
		self.fileRepository = fileRepository
	}

	// MARK: - Internal methods

	/// Сборка модуля стартового экрана.
	/// - Returns: контроллер с проставленными зависимостями VIP цикла.
	func assembly(openFileClosure: EmptyClosure?, openAboutClosure: EmptyClosure?) -> MainViewController {
		let viewController = MainViewController(collectionViewLayout: UICollectionViewLayout())
		let presenter = MainPresenter(
			viewController: viewController,
			openFileClosure: openFileClosure,
			openAboutClosure: openAboutClosure
		)

		let interactor = MainInteractor(presenter: presenter, fileRepository: fileRepository)
		viewController.interactor = interactor

		return viewController
	}
}
