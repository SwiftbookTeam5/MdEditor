//
//  RegularTaskTest.swift
//  
//
//  Created by Руслан Мингалиев on 08.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class RegularTaskTest: XCTestCase {
	func test_initialization_propertyisCompleteShuldBeFalse() {
		// arrange
		let sut = Task(title: "TestTask")

		// assert
		XCTAssertNotEqual(sut.completed, true, "Невероное значение параметра Completed, необходим False")
	}
	func test_isComplete_setTrue_propertyisCompleteShuldBeFalse() {
		// arrange
		let sut = Task(title: "TestTask")
		
		// act
		sut.completed = true
		
		// assert
		XCTAssertNotEqual(sut.completed, false, "Невероное значение параметра Completed, необходим True")
	}
}
