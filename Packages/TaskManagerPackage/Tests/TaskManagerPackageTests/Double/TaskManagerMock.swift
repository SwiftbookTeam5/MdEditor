//
//  TaskManagerMock.swift
//  
//
//  Created by Дмитрий Лубов on 06.02.2024.
//

@testable import TaskManagerPackage

final class TaskManagerMock: ITaskManager {
	static let importantTaskHigh = ImportantTask(title: "importantTaskHigh", taskPriority: .high)
	static let importantTaskMedium: ImportantTask = {
		let task = ImportantTask(title: "importantTaskHigh", taskPriority: .medium)
		task.completed = true
		return task
	}()
	static let importantTaskLow = ImportantTask(title: "importantTaskHigh", taskPriority: .low)
	static let regularTaskCompleted = RegularTask(title: "regularTaskCompleted", completed: true)
	static let regularTaskUncompleted = RegularTask(title: "regularTaskUncompleted")

	func allTasks() -> [TaskManagerPackage.Task] {
		[
			TaskManagerMock.regularTaskUncompleted,
			TaskManagerMock.importantTaskHigh,
			TaskManagerMock.importantTaskLow,
			TaskManagerMock.importantTaskMedium,
			TaskManagerMock.regularTaskCompleted
		]
	}

	func completedTasks() -> [TaskManagerPackage.Task] {
		[
			TaskManagerMock.regularTaskCompleted,
			TaskManagerMock.importantTaskMedium
		]
	}

	func uncompletedTasks() -> [TaskManagerPackage.Task] {
		[
			TaskManagerMock.regularTaskUncompleted,
			TaskManagerMock.importantTaskHigh,
			TaskManagerMock.importantTaskLow
		]
	}

	func addTask(task: TaskManagerPackage.Task) {
		fatalError("Not implemented!")
	}

	func addTasks(tasks: [TaskManagerPackage.Task]) {
		fatalError("Not implemented!")
	}

	func removeTask(task: TaskManagerPackage.Task) {
		fatalError("Not implemented!")
	}
}
