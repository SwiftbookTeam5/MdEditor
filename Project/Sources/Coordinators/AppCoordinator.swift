//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Татьяна Исаева on 11.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private var window: UIWindow?
	private let taskManager: ITaskManager
	private let repository: ITaskRepository

	// MARK: - Initialization

	init(window: UIWindow?, taskManager: ITaskManager, repository: ITaskRepository) {
		self.window = window
		self.taskManager = taskManager
		self.repository = repository
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
		let coordinator = TodoListCoordinator(
			navigationController: navigationController,
			taskManager: taskManager,
			repository: repository
		)

		addDependency(coordinator)
		coordinator.start()
	}
}
