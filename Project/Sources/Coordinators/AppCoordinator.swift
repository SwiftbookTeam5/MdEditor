//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Татьяна Исаева on 11.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import TaskManagerPackage
import FileManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private var window: UIWindow?
	private let taskManager: ITaskManager
	private let fileRepository: IFileRepository
	private let fileExplorer: IFileExplorer

	// MARK: - Initialization

	init(window: UIWindow?, taskManager: ITaskManager, fileRepository: IFileRepository, fileExplorer: IFileExplorer) {
		self.window = window
		self.taskManager = taskManager
		self.fileRepository = fileRepository
		self.fileExplorer = fileExplorer
		self.navigationController = UINavigationController()
	}

	// MARK: - Internal methods

	override func start() {
		runLoginFlow()
	}

	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			self?.runMainFlow()
			coordinator.map { self?.removeDependency($0) }
		}

		coordinator.start()

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

	func runMainFlow() {
		let coordinator = MainCoordinator(
			navigationController: navigationController,
			fileRepository: fileRepository,
			fileExplorer: fileExplorer
		)

		addDependency(coordinator)
		coordinator.start()
	}
}
