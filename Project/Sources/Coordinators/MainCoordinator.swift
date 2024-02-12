//
//  MainCoordinator.swift
//  MdEditor
//
//  Created by Александра Рязанова on 01.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import FileManagerPackage

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

	private func runOpenFileFlow() {
		let coordinator = OpenFileCoordinator(
			navigationController: navigationController,
			fileExplorer: fileExplorer,
			url: nil
		)

		addDependency(coordinator)
		coordinator.start()
	}

	private func showAboutScene() {
		let assembler = AboutAppAssembler()
		let viewController = assembler.assembly()

		navigationController.pushViewController(viewController, animated: true)
	}

	private func showMainScene() {
		let assembler = MainAssembler(fileRepository: fileRepository)
		let viewController = assembler.assembly {
			self.runOpenFileFlow()
		} openAboutClosure: {
			self.showAboutScene()
		}

		navigationController.pushViewController(viewController, animated: true)
	}
}
