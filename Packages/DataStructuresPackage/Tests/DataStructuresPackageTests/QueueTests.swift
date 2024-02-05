//
//  QueueTests.swift
//  
//
//  Created by Александра Рязанова on 07.01.2024.
//

import XCTest
@testable import DataStructuresPackage

final class QueueTests: XCTestCase {
	
	func test_init_emptyQueue_shouldBeEmpty() {
		let sut = Queue<Int>()
		
		XCTAssertTrue(sut.isEmpty, "Очередь должна быть пуста.")
		XCTAssertEqual(sut.count, 0, "Количество элементов в очереди должно быть равно 0.")
		XCTAssertNil(sut.peek, "Очередь не должна возвращать элемент.")
	}
	
	func test_enqueue_twoValues_shouldBeCorrectCountAndFirstElement() {
		var sut = Queue<Int>()
		
		sut.enqueue(1)
		sut.enqueue(2)
		
		XCTAssertEqual(sut.count, 2, "Количество элементов в очереди должно быть равно 2.")
		XCTAssertEqual(sut.peek, 1, "Первый элемент в очереди имеет неверное значение.")
	}
	
	func test_dequeue_shouldBeCorrect() {
		var sut = Queue<Int>()
		sut.enqueue(1)
		sut.enqueue(2)
		
		let value = sut.dequeue()
		
		XCTAssertEqual(sut.count, 1, "Количество элементов в очереди должно быть равно 1.")
		XCTAssertEqual(value, 1, "Очередь вернула неверное значение.")
		XCTAssertEqual(sut.peek, 2, "Первый элемент в очереди имеет неверное значение.")
	}
}

