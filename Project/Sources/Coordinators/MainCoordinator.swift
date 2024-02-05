//
//  MainCoordinator.swift
//  MdEditor
//
//  Created by Александра Рязанова on 01.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

final class MainCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let fileRepository: IFileRepository
	private let fileExplorer: IFileExplorer

	// MARK: - Initialization

	init(navigationController: UINavigationController, fileRepository: IFileRepository, fileExplorer: IFileExplorer) {
		self.navigationController = navigationController
		self.fileRepository = fileRepository
		self.fileExplorer = fileExplorer
	}

	// MARK: - Internal methods

	override func start() {
		showMainScene()
	}

	func runOpenFileFlow() {
		let coordinator = OpenFileCoordinator(
			navigationController: navigationController,
			fileExplorer: fileExplorer,
			path: ""
		)

		addDependency(coordinator)
		coordinator.start()
	}

	private func showMainScene() {
		let assembler = MainAssembler(fileRepository: fileRepository)
		let viewController = assembler.assembly {
			self.runOpenFileFlow()
		}

		navigationController.pushViewController(viewController, animated: true)
	}
}
