//
//  ImportantTaskTest.swift
//  
//
//  Created by Руслан Мингалиев on 08.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class ImportantTaskTests: XCTestCase {
	
	func test_createImportantTask_dedlineShouldBeIn3Days() {
		
		// arrange
		let sut = ImportantTask(title: title, taskPriority: .low)
		
		// act
		let dateToDeadLine = createDateTo(deadLine: sut.deadLine)
		let testDateToDeadLine = createDateAccordingPriorityTask(priority: Priority.low.rawValue)
		
		// assert
		XCTAssertEqual(sut.taskPriority.rawValue, 0, "Невероное значение параметра taskPriority, необходим Low")
		XCTAssertEqual(dateToDeadLine, testDateToDeadLine, "Невероное значение параметра deadLine")
	}
	
	func test_createImportantTask_dedlineShouldBeIn2Days() {
	
		// arrange
		let sut = ImportantTask(title: title, taskPriority: .medium)
		
		// act
		let dateToDeadLine = createDateTo(deadLine: sut.deadLine)
		let testDateToDeadLine = createDateAccordingPriorityTask(priority: Priority.medium.rawValue)
		
		// assert
		XCTAssertEqual(sut.taskPriority.rawValue, 1, "Невероное значение параметра taskPriority, необходим Medium")
		XCTAssertEqual(dateToDeadLine, testDateToDeadLine, "Невероное значение параметра deadLine")
	}
	
	func test_createImportantTask_dedlineShouldBeIn1Days() {
		
		// arrange
		let sut = ImportantTask(title: title, taskPriority: .high)
		
		// act
		let dateToDeadLine = createDateTo(deadLine: sut.deadLine)
		let testDateToDeadLine = createDateAccordingPriorityTask(priority: Priority.high.rawValue)
		
		// assert
		XCTAssertEqual(sut.taskPriority.rawValue, 2, "Невероное значение параметра taskPriority, необходим High")
		XCTAssertEqual(dateToDeadLine, testDateToDeadLine, "Невероное значение параметра deadLine")
	}
	func test_init_withTitleAndLowPriority_taskShouldHaveCorrectTitleAndPriorityAndNotBeCompleted() {
		
		// arrange
		let sut = ImportantTask(title: title, taskPriority: .low)
		
		// act
		let testTitle = sut.title
		let testPriority = sut.taskPriority
		let isCompleted = sut.completed

		// assert
		XCTAssertEqual(testTitle, title, "Имя новой задачи не корректно")
		XCTAssertEqual(testPriority, .low ,"Приоритет новой задачи не корректен")
		XCTAssertFalse(isCompleted, "Новая задача не должна быть выполненной")
	}
}
// MARK: - TestData

private extension ImportantTaskTests {
	var title: String {
		"TestImportantTask"
	}
	///Функция для создания даты, и последующего сравнения
	func createDateTo(deadLine: Date) -> DateComponents {
		Calendar.current.dateComponents([.day, .month, .year], from: deadLine)
	}
	/// Функция создания даты с учетом приритета в задании
	func createDateAccordingPriorityTask(priority: Int) -> DateComponents {
		let testDateForTaskPriority = Calendar.current.date(byAdding: .day, value: priority, to: Date())
		let dateDatedLineTest = Calendar.current.dateComponents([.day, .month, .year], from: testDateForTaskPriority!)
		
		return dateDatedLineTest
	}
	
	enum Priority: Int {
		case low = 3
		case medium = 2
		case high = 1
	}
	
}
