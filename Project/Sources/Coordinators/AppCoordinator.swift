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
import NetworkLayerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private var window: UIWindow?
	private let taskManager: ITaskManager
	private let networkService: INetworkService

	// MARK: - Initialization

	init(window: UIWindow?, taskManager: ITaskManager, networkService: INetworkService) {
		self.window = window
		self.taskManager = taskManager
		self.networkService = networkService
		self.navigationController = UINavigationController()
	}

	// MARK: - Internal methods

	override func start() {
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()

		runLoginFlow()
	}

	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController, networkService: networkService)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			self?.runMainFlow()
			coordinator.map { self?.removeDependency($0) }
		}

		coordinator.start()
	}

	func runMainFlow() {
		let coordinator = MainCoordinator(navigationController: navigationController)
		addDependency(coordinator)
		coordinator.start()
	}

	func runTodoListFlow() {
		let coordinator = TodoListCoordinator(navigationController: navigationController, taskManager: taskManager)
		addDependency(coordinator)
		coordinator.start()
	}
}

// MARK: - ITestCoordinator

extension AppCoordinator: ITestCoordinator {

	/// Запускает флоу в зависимости от переданных параметров
	/// - Parameter parameters: параметры запуска приложения
	func testStart(parameters: [LaunchArguments: Bool]) {
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()

		if let startTodoList = parameters[LaunchArguments.startTodoList], startTodoList {
			runTodoListFlow()
		} else {
			runLoginFlow()
		}
	}
}
