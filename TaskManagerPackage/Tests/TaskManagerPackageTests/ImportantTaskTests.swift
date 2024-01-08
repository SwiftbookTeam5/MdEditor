//
//  ImportantTaskTest.swift
//  
//
//  Created by Руслан Мингалиев on 08.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class ImportantTaskTest: XCTestCase {
	
	func test_createImportantTask_dedlineShouldBeIn3Days() {
		// arrange
		let sut = ImportantTask(title: "TestImportantTask", taskPriority: .low)
		
		// act
		let dateDatedLine = Calendar.current.dateComponents([.day, .month, .year], from: sut.deadLine)
		let testDateForTaskPriority = Calendar.current.date(byAdding: .day, value: 3, to: Date())
		let dateDatedLineTest = Calendar.current.dateComponents([.day, .month, .year], from: testDateForTaskPriority!)
		
		// assert
		XCTAssertEqual(sut.taskPriority.rawValue, 0, "Невероное значение параметра taskPriority, необходим Low")
		XCTAssertEqual(dateDatedLine, dateDatedLineTest, "Невероное значение параметра deadLine")
	}
	
	func test_createImportantTask_dedlineShouldBeIn2Days() {
		// arrange
		let sut = ImportantTask(title: "TestImportantTask", taskPriority: .medium)
		
		// act
		let dateDatedLine = Calendar.current.dateComponents([.day, .month, .year], from: sut.deadLine)
		let testDateForTaskPriority = Calendar.current.date(byAdding: .day, value: 2, to: Date())
		let dateDatedLineTest = Calendar.current.dateComponents([.day, .month, .year], from: testDateForTaskPriority!)
		
		// assert
		XCTAssertEqual(sut.taskPriority.rawValue, 1, "Невероное значение параметра taskPriority, необходим Medium")
		XCTAssertEqual(dateDatedLine, dateDatedLineTest, "Невероное значение параметра deadLine")
	}
	
	func test_createImportantTask_dedlineShouldBeIn1Days() {
		// arrange
		let sut = ImportantTask(title: "TestImportantTask", taskPriority: .high)
		
		// act
		let dateDatedLine = Calendar.current.dateComponents([.day, .month, .year], from: sut.deadLine)
		let testDateForTaskPriority = Calendar.current.date(byAdding: .day, value: 1, to: Date())
		let dateDatedLineTest = Calendar.current.dateComponents([.day, .month, .year], from: testDateForTaskPriority!)
		
		// assert
		XCTAssertEqual(sut.taskPriority.rawValue, 2, "Невероное значение параметра taskPriority, необходим High")
		XCTAssertEqual(dateDatedLine, dateDatedLineTest, "Невероное значение параметра deadLine")
	}
	func test_createImportantTask_initializationShouldBeValid() {
		// arrange
		let sut = ImportantTask(title: "TestImportantTask", taskPriority: .low)
		
		// assert
		XCTAssertNotNil(sut.title, "Отсутствует Title")
		XCTAssertNotNil(sut.completed, "Отсутствует Completed")
		XCTAssertNotNil(sut.taskPriority, "Отсутствует taskPriority")
		XCTAssertNotNil(sut.deadLine, "Отсутствует deadLine")
	}
}
