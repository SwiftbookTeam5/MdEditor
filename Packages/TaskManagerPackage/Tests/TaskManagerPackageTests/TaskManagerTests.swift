//
//  TaskManagerTests.swift
//  
//
//  Created by Александра Рязанова on 09.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class TaskManagerTests: XCTestCase {

	func test_initList_withTasks_shouldHaveCorrectCount() {

		// arrange
		let tasks = Task.getTasksStub()
		let sut = makeSUT(taskList: tasks)

		// act
		let allTasks = sut.allTasks()

		// assert
		XCTAssertEqual(
			allTasks.count,
			tasks.count,
			"Неверное количество заданий при инициализации"
		)
	}

	func test_addTasks_withTasks_shouldHaveCorrectCount() {

		// arrange
		let tasks = Task.getTasksStub()
		let sut = makeSUT()

		// act
		sut.addTasks(tasks: tasks)
		let allTasks = sut.allTasks()

		// assert
		XCTAssertEqual(
			allTasks.count,
			tasks.count,
			"Неверное количество заданий при добавлении"
		)
	}

	func test_completedTasks_withTasks_shouldHaveCorrectCount() {

		// arrange
		let tasks = Task.getTasksStub()
		let sut = makeSUT(taskList: tasks)

		// act
		let completedTasks = sut.completedTasks()

		// assert
		XCTAssertEqual(
			completedTasks.count,
			tasks.filter({ $0.completed }).count,
			"Неверное количество завершенных заданий"
		)
	}

	func test_uncompletedTasks_withTasks_shouldHaveCorrectCount() {

		// arrange
		let tasks = Task.getTasksStub()
		let sut = makeSUT(taskList: tasks)

		// act
		let uncompletedTasks = sut.uncompletedTasks()

		// assert
		XCTAssertEqual(
			uncompletedTasks.count,
			tasks.filter({ !$0.completed }).count,
			"Неверное количество не завершенных заданий"
		)
	}
}

// MARK: - Private methods

private extension TaskManagerTests {

	func makeSUT(taskList: [Task] = [Task]()) -> ITaskManager {
		return TaskManager(taskList: taskList)
	}
}
