//
//  OrderedTaskManagerTests.swift
//  
//
//  Created by Александра Рязанова on 09.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerTests: XCTestCase {

	func test_allTasks_withFiveTasks_shouldBeFiveTasksOrderedByPriority() {
		let sut = makeSut()
		let validResultTasks = TasksStub.allOrderedTasks

		let resultTasks = sut.allTasks()

		XCTAssertEqual(resultTasks.count, 5, "В списке всех заданий должно быть пять задач.")
		XCTAssertEqual(resultTasks, validResultTasks, "Cписок всех заданий должен быть отсортирован по приоритету.")
	}

	func test_completedTasks_withTwoCompletedTasks_shouldBeTwoCompletedTasksOrderedByPriority() {
		let sut = makeSut()
		let validResultTask = TasksStub.completedOrderedTasks

		let resultTasks = sut.completedTasks()

		XCTAssertEqual(resultTasks.count, 2, "В списке завершенных заданий должно быть две задачи.")
		XCTAssertEqual(resultTasks, validResultTask, "Cписок заданий должен быть отсортирован по приоритету.")
	}

	func test_uncompletedTasks_withTreeUncompletedTasks_shouldBeThreeUncompletedTasksOrderedByPriority() {
		let sut = makeSut()
		let validResultTask = TasksStub.uncompletedOrderedTasks

		let resultTasks = sut.uncompletedTasks()

		XCTAssertEqual(resultTasks.count, 3, "В списке незавершенных заданий должно быть три задачи.")
		XCTAssertEqual(resultTasks, validResultTask, "Cписок заданий должен быть отсортирован по приоритету.")
	}
}

// MARK: - TestData

private extension OrderedTaskManagerTests {

	enum TasksStub {
		static let allOrderedTasks = [
			TaskManagerMock.importantTaskHigh,
			TaskManagerMock.importantTaskMedium,
			TaskManagerMock.importantTaskLow,
			TaskManagerMock.regularTaskUncompleted,
			TaskManagerMock.regularTaskCompleted
		]

		static let completedOrderedTasks = [
			TaskManagerMock.importantTaskMedium,
			TaskManagerMock.regularTaskCompleted
		]

		static let uncompletedOrderedTasks = [
			TaskManagerMock.importantTaskHigh,
			TaskManagerMock.importantTaskLow,
			TaskManagerMock.regularTaskUncompleted
		]
	}

	func makeSut() -> OrderedTaskManager {
		OrderedTaskManager(taskManager: TaskManagerMock())
	}
}
