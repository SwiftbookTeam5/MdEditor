//
//  File.swift
//  
//
//  Created by Руслан Мингалиев on 08.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class ImportantTaskTest: XCTestCase {
	func test_createImportantTask_dedlineShouldBeIn3Days() {
		let sut = ImportantTask(title: "TestImportantTask", taskPriority: .low)
		
		let dateDatedLine = Calendar.current.dateComponents([.day, .month, .year], from: sut.deadLine)
		let testDateForLowTaskPriority = Calendar.current.date(byAdding: .day, value: 3, to: Date())
		let dateDatedLineTest = Calendar.current.dateComponents([.day, .month, .year], from: testDateForLowTaskPriority!)
		
		XCTAssertEqual(sut.taskPriority.rawValue, 0, "Невероное значение параметра taskPriority, необходим Low")
		XCTAssertEqual(dateDatedLine, dateDatedLineTest, "Невероное значение параметра deadLine")
		
	}
	func test_createImportantTask_dedlineShouldBeIn2Days() {
		let sut = ImportantTask(title: "TestImportantTask", taskPriority: .medium)
		
		let dateDatedLine = Calendar.current.dateComponents([.day, .month, .year], from: sut.deadLine)
		let testDateForLowTaskPriority = Calendar.current.date(byAdding: .day, value: 2, to: Date())
		let dateDatedLineTest = Calendar.current.dateComponents([.day, .month, .year], from: testDateForLowTaskPriority!)
		
		XCTAssertEqual(sut.taskPriority.rawValue, 1, "Невероное значение параметра taskPriority, необходим Medium")
		XCTAssertEqual(dateDatedLine, dateDatedLineTest, "Невероное значение параметра deadLine")
	}
	func test_createImportantTask_dedlineShouldBeIn1Days() {
		
		let sut = ImportantTask(title: "TestImportantTask", taskPriority: .high)
		
		let dateDatedLine = Calendar.current.dateComponents([.day, .month, .year], from: sut.deadLine)
		let testDateForLowTaskPriority = Calendar.current.date(byAdding: .day, value: 1, to: Date())
		let dateDatedLineTest = Calendar.current.dateComponents([.day, .month, .year], from: testDateForLowTaskPriority!)
		
		XCTAssertEqual(sut.taskPriority.rawValue, 2, "Невероное значение параметра taskPriority, необходим High")
		XCTAssertEqual(dateDatedLine, dateDatedLineTest, "Невероное значение параметра deadLine")
	}
	func test_createImportantTask_initializationShouldBeValid() {
		
		let sut = ImportantTask(title: "TestImportantTask", taskPriority: .low)
		
		XCTAssertNotNil(sut.title)
		XCTAssertNotNil(sut.completed)
		XCTAssertNotNil(sut.taskPriority)
		XCTAssertNotNil(sut.deadLine)
		
		
	}
	
}

