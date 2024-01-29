//
//  TodoListCoordinator.swift
//  MdEditor
//
//  Created by Татьяна Исаева on 12.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit
import TaskManagerPackage

final class TodoListCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let taskManager: ITaskManager
	private let repository: ITaskRepository

	// MARK: - Initialization

	init(navigationController: UINavigationController, taskManager: ITaskManager, repository: ITaskRepository) {
		self.navigationController = navigationController
		self.taskManager = taskManager
		self.repository = repository
	}

	// MARK: - Internal methods

	func start() {
		showTodoListScene()
	}

	private func showTodoListScene() {
		let orderedTaskManager = OrderedTaskManager(taskManager: taskManager)
		orderedTaskManager.addTasks(tasks: repository.getTasks())

		let assembler = TodoListAssembler(taskManager: orderedTaskManager)
		let viewController = assembler.assembly()

		navigationController.pushViewController(viewController, animated: true)
	}
}
