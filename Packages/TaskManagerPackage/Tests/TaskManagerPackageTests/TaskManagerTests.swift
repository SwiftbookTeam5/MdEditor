//
//  TaskManagerTests.swift
//  
//
//  Created by Александра Рязанова on 09.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class TaskManagerTests: XCTestCase {

	private let completedTask = Task(title: "completedTask", completed: true)
	private let uncompletedTask = Task(title: "uncompletedTask", completed: false)

	func test_init_withoutTasks_shouldBeZeroTask() {
		let sut = TaskManager()

		XCTAssertEqual(sut.countTasks, 0, "Количество задач в менеджере заданий должно быть равно 0.")
	}

	func test_allTasks_fromTaskManagerWithTwoTasks_shouldBeContainsTasksAndCorrentCount() {
		let sut = makeSUT()

		let allTasks = sut.allTasks()
		let isFirsTask = allTasks.contains(completedTask)
		let isSecondTask = allTasks.contains(uncompletedTask)

		XCTAssertEqual(allTasks.count, 2, "Менеджер заданий возвращает неверное количество задач.")
		XCTAssertTrue(isFirsTask, "Менеджер заданий не вернул первую задачу.")
		XCTAssertTrue(isSecondTask, "Менеджер заданий не вернул вторую задачу.")
	}

	func test_addTask_inEmptyTaskManager_shouldBeOneTask() {
		let sut = TaskManager()

		sut.addTask(task: completedTask)
		let allTasks = sut.allTasks()
		let isNewTask = allTasks.contains(completedTask)
		
		XCTAssertEqual(allTasks.count, 1, "В списке всех заданий должна быть одна добавленная задача.")
		XCTAssertTrue(isNewTask, "В списке всех заданий должна быть добавленная задача.")
	}

	func test_addTasks_inEmptyTaskManager_shouldBeTwoTasks() {
		let sut = TaskManager()

		sut.addTasks(tasks: [completedTask, uncompletedTask])
		let allTasks = sut.allTasks()
		let isCompletedTask = allTasks.contains(completedTask)
		let isUncompletedTask = allTasks.contains(uncompletedTask)

		XCTAssertEqual(allTasks.count, 2, "В списке всех заданий должнo быть две добавленные задачи.")
		XCTAssertTrue(
			isCompletedTask,
			"После добавления двух задач, в списке всех заданий должна быть завершенная задача."
		)
		XCTAssertTrue(
			isUncompletedTask,
			"После добавления двух задач, в списке всех заданий должна быть незавершенная задача."
		)
	}
	
	func test_removeTask_fromTaskManagerWithTwoTask_shouldBeOneTask() {
		let sut = makeSUT()

		sut.removeTask(task: completedTask)
		let allTasks = sut.allTasks()
		let isCompletedTask = allTasks.contains(completedTask)
		let isUncompletedTask = allTasks.contains(uncompletedTask)

		XCTAssertEqual(allTasks.count, 1, "После удаления, в списке всех заданий должна остаться одна задача.")
		XCTAssertTrue(
			isUncompletedTask,
			"После удаления задачи, в списке всех заданий должна остаться незавершенная задача."
		)
		XCTAssertFalse(
			isCompletedTask,
			"После удаления задачи, в списке всех заданий не должна оставаться завершенная задача."
		)
	}

	func test_completedTasks_fromTaskManagerWithOneCompletedAndOneUncompletedTasks_shouldBeOneCompletedTask() {
		let sut = makeSUT()

		let completedTasks = sut.completedTasks()
		let isCompletedTask = completedTasks.contains(completedTask)
		let isUncompletedTask = completedTasks.contains(uncompletedTask)

		XCTAssertEqual(completedTasks.count, 1, "В списке завершенных заданий должна быть одна задача.")
		XCTAssertTrue(isCompletedTask, "В списке завершенных заданий должна быть завершенная задача.")
		XCTAssertFalse(isUncompletedTask, "В списке завершенных заданий не должна быть незавершенная задача.")
	}

	func test_uncompletedTasks_fromTaskManagerWithOneCompletedAndOneUncompletedTasks_shouldBeOneUnompletedTask() {
		let sut = makeSUT()
		
		let uncompletedTasks = sut.uncompletedTasks()
		let isCompletedTask = uncompletedTasks.contains(completedTask)
		let isUncompletedTask = uncompletedTasks.contains(uncompletedTask)
		
		XCTAssertEqual(uncompletedTasks.count, 1, "В списке завершенных заданий должна быть одна задача.")
		XCTAssertTrue(isUncompletedTask, "В списке незавершенных заданий должна быть незавершенная задача.")
		XCTAssertFalse(isCompletedTask, "В списке незавершенных заданий не должна быть завершенная задача.")
	}
}

// MARK: - TestData

private extension TaskManagerTests {

	func makeSUT() -> TaskManager {
		TaskManager(taskList: [completedTask, uncompletedTask])
	}
}
