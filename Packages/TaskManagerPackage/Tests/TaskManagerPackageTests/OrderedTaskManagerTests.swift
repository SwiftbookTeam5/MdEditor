//
//  OrderedTaskManagerTests.swift
//  
//
//  Created by Александра Рязанова on 09.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerTests: XCTestCase {

	func test_allTasks_withTasks_shouldBeSorted() {

		// arrange
		let tasks = ImportantTask.getImportantTasksStub()
		let sut = makeSUT(taskList: tasks)

		// act
		let allTasks = sut.allTasks()

		// assert
		if allTasks.count >= 2,
		   let firstTask = allTasks[0] as? ImportantTask,
		   let secondTask = allTasks[1] as? ImportantTask {

			XCTAssertTrue(
				firstTask.taskPriority.rawValue >= secondTask.taskPriority.rawValue,
				"Неверная сортировка при получении всех заданий"
			)
		}
	}
}

// MARK: - Private methods

private extension OrderedTaskManagerTests {

	func makeSUT(taskList: [Task] = [Task]()) -> ITaskManager {
		let manager = OrderedTaskManager(taskManager: TaskManager())
		manager.addTasks(tasks: taskList)

		return manager
	}
}
