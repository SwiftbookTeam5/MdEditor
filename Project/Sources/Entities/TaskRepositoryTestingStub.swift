//
//  TaskRepositoryTestingStub.swift
//  MdEditor
//
//  Created by Александра Рязанова on 30.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import TaskManagerPackage

/// Stub Репозиторя для получения заданий.
final class TaskRepositoryTestingStub: ITaskRepository {

	/// Возвращает предустановленные данные для приолжения.
	/// - Returns: Массив заданий.
	func getTasks() -> [Task] {
		[
			ImportantTask(title: L10n.Task.default, taskPriority: .high),
			RegularTask(title: L10n.Task.default, completed: true),
			ImportantTask(title: L10n.Task.default, taskPriority: .low),
			RegularTask(title: L10n.Task.default),
			ImportantTask(title: L10n.Task.default, taskPriority: .medium)
		]
	}
}
