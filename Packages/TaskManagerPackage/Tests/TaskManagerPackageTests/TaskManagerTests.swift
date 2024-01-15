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

	func test_addTask_withTask_shouldBeSuccess() {

		// arrange
		let title = "05 Task"
		let newTask = Task(title: title)
		let sut = makeSUT()

		// act
		sut.addTask(task: newTask)
		let allTasks = sut.allTasks()
		
		// assert
		XCTAssertEqual(
			allTasks.count,
			1,
			"Неверное количество заданий при добавлении задания"
		)

		XCTAssertEqual(
			allTasks.last?.title,
			title,
			"Неверное название задания при добавлении одного задания"
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
	
	func test_removeTask_withOneTask_shouldHaveCorrectCount() {

		// arrange
		let newTask = Task(title: "01 Task")
		let sut = makeSUT()
		sut.addTask(task: newTask)

		// act
		sut.removeTask(task: newTask)
		let allTasks = sut.allTasks()

		// assert
		XCTAssertEqual(
			allTasks.count,
			0,
			"Неверное количество заданий при удалении "
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
