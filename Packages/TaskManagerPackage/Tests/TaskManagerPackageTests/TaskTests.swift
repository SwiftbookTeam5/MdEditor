import XCTest
@testable import TaskManagerPackage

final class TaskTests: XCTestCase {

	let title = "Task_01"

	func test_initTask_withTitle_shouldBeEqualTitle() {
		let sut = Task(title: title)

		XCTAssertEqual(sut.title, title, "Название задания должно совпадать с title")
	}

	func test_initCompletedTask_shouldBeCompleted() {
		let sut = Task(title: title, completed: true)

		XCTAssertTrue(sut.completed, "Задача должна быть выполнена")
	}

	func test_initTask_withoutValueCompleted_shouldBeUncompleted() {
		let sut = Task(title: title)

		XCTAssertFalse(sut.completed, "По умолчанию задание должно быть не выполнено")
	}
}

// MARK: - TaskStub

extension Task {

	static func getTasksStub() -> [Task] {
		let tasks = [
			Task(title: "01 Task", completed: true),
			Task(title: "02 Task"),
			Task(title: "03 Task", completed: true),
			Task(title: "04 Task"),
		]
		
		return tasks
	}
}
