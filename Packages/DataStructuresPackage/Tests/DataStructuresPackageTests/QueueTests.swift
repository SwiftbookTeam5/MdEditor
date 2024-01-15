//
//  QueueTests.swift
//  
//
//  Created by Александра Рязанова on 07.01.2024.
//

import XCTest
@testable import DataStructuresPackage

final class QueueTests: XCTestCase {
	
	func test_enqueue_withValue_shouldHaveCorrectCount() {

		// arrange
		var sut = Queue<Int>()

		// act
		sut.enqueue(1)

		// assert
		XCTAssertEqual(
			sut.count,
			1,
			"Неверное количество элементов в списке при добавлении в конец очереди"
		)
	}
	
	func test_enqueue_withValues_shouldHaveCorrectCount() {

		// arrange
		let numbers = [1, 2, 3]
		let sut = makeSUT(with: numbers)

		// assert
		XCTAssertEqual(
			sut.count,
			numbers.count,
			"Неверное количество элементов в списке при добавлении в конец очереди"
		)
	}

	func test_dequeue_withFullQueue_shouldHaveCorrectCount() {

		// arrange
		let numbers = [1, 2, 3]
		var sut = makeSUT(with: numbers)
		
		// act
		sut.dequeue()

		// assert
		XCTAssertEqual(
			sut.count,
			numbers.count - 1,
			"Неверное количество элементов в списке при добавлении в конец очереди"
		)
	}

	func test_dequeue_withOneElement_shouldBeEmpty() {

		// arrange
		var sut = Queue<Int>()
		sut.enqueue(1)

		// act
		sut.dequeue()

		// assert
		XCTAssertTrue(
			sut.isEmpty,
			"Ошибка, очередь не пустая после удаления единственного элемента"
		)
	}
	
	func test_dequeue_withEmptyQueue_shouldBeNilValue() {

		// arrange
		var sut = Queue<Int>()

		// act
		let value = sut.dequeue()

		XCTAssertNil(
			value,
			"Ошибка, при удалении из пустой очереди вернулось значение"
		)
	}

	func test_peek_withFullQueue_shouldHaveCorrectValue() {

		// arrange
		let numbers = [1, 2, 3]
		let sut = makeSUT(with: numbers)

		// assert
		XCTAssertEqual(
			sut.peek,
			numbers.first,
			"Неверное значение первого элемента очереди"
		)
	}

	func test_peek_withEmptyQueue_shouldBeNilValue() {

		// arrange
		let sut = Queue<Int>()

		// assert
		XCTAssertNil(
			sut.peek,
			"Неверное значение первого элемента пустой очереди"
		)
	}
}

// MARK: - Private methods

private extension QueueTests {

	func makeSUT(with numbers: [Int]) -> Queue<Int> {
		var sut = Queue<Int>()
		numbers.forEach { sut.enqueue($0) }

		return sut
	}
}
