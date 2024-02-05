//
//  TaskManagerBuilder.swift
//  MdEditor
//
//  Created by Александра Рязанова on 02.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import TaskManagerPackage

/// Класс для сборки менеджера заданий
final class TaskManagerBuilder {

	/// Собирает менеджер для работы с заданиями
	/// - Parameter repository: источник заданий
	/// - Returns: менеджер заданий
	func build(repository: ITaskRepository) -> ITaskManager {
		let taskManager = TaskManager()
		let orderedTaskManager = OrderedTaskManager(taskManager: taskManager)
		orderedTaskManager.addTasks(tasks: repository.getTasks())

		return orderedTaskManager
	}
}
