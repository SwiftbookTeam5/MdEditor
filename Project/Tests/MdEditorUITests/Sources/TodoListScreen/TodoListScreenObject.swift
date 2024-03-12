//
//  TodoListScreenObject.swift
//  MdEditorUITests
//
//  Created by Дмитрий Лубов on 28.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest

final class TodoListScreenObject: BaseScreenObject {

	// MARK: - Private properties

	private lazy var navigationBar = app.navigationBars.firstMatch
	private lazy var tableView = app.tables[AccessibilityIdentifier.TodoList.tableView.description]

	// MARK: - ScreenObject methods

	/// Проверяет является ли текущий экран TodoList
	/// - Returns: сам объект self
	@discardableResult
	func isTodoList() -> Self {
		let navigationBarTitle = navigationBar.staticTexts[L10n.TodoList.title]
		assert(navigationBarTitle, [.exists], timeout: 10)
		assert(tableView, [.exists])

		return self
	}

	/// Проверяет соответствует ли количество секций переданному значению
	/// - Parameter count: ожидаемое количество секций
	/// - Returns: сам объект self
	@discardableResult
	func checkNumberOfSections(_ count: Int) -> Self {
		let numberOfSections = tableView.otherElements.staticTexts.count

		XCTAssertEqual(numberOfSections, count, "Количество секций должно быть равно \(count).")

		return self
	}

	/// Проверяет соответствует ли название заголовка секции
	/// - Parameters:
	///   - index: индекс секции
	///   - title: название заголовка секции
	/// - Returns: сам объект self
	@discardableResult
	func checkSectionTitle(index: Int, title: String) -> Self {
		let section = tableView.otherElements[AccessibilityIdentifier.TodoList.section(index: index).description]

		assert(section, [.exists])
		XCTAssertEqual(section.label, title, "Заголовок секции [\(index)] должно быть - \(title).")

		return self
	}

	/// Проверяет соответствует ли название задания в ячейке
	/// - Parameters:
	///   - section: индекс секции
	///   - row: индекс строки
	///   - title: название задания
	/// - Returns: сам объект self
	@discardableResult
	func checkCellTitle(section: Int, row: Int, title: String) -> Self {
		let cell = app.cells[AccessibilityIdentifier.TodoList.cell(section: section, index: row).description]
		let cellTitle = cell.staticTexts.element(boundBy: 0).label

		assert(cell, [.exists])
		XCTAssertEqual(cellTitle, title, "Заголовок ячейки [\(section):\(row)] должно быть - \(title).")

		return self
	}

	/// Проверяет соответствует ли количество не выбранных строк переданному значению
	/// - Parameter count: ожидаемое количество не выбранных строк
	/// - Returns: сам объект self
	@discardableResult
	func checkCountOfNotSelectedCells(_ count: Int) -> Self {
		let cells = app.cells.allElementsBoundByIndex.filter { !$0.isSelected }

		XCTAssertEqual(cells.count, count, "Количество не выбранных ячеек должно быть равно \(count)")

		return self
	}

	/// Проверяет соответствует ли количество выбранных строк переданному значению
	/// - Parameter count: ожидаемое количество выбранных строк
	/// - Returns: сам объект self
	@discardableResult
	func checkCountOfSelectedCells(_ count: Int) -> Self {
		let cells = app.cells.allElementsBoundByIndex.filter { $0.isSelected }

		XCTAssertEqual(cells.count, count, "Количество выбранных ячеек должно быть равно \(count).")

		return self
	}

	/// Меняет статус задания
	/// - Parameters:
	///   - section: индекс секции
	///   - row: индекс строки
	/// - Returns: сам объект self
	@discardableResult
	func changeTaskStatusIn(section: Int, row: Int) -> Self {
		let cell = app.cells[AccessibilityIdentifier.TodoList.cell(section: section, index: row).description]
		assert(cell, [.exists])

		cell.tap()

		return self
	}
}
