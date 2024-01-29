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
	private lazy var table = app.tables[AccessibilityIdentifier.TodoList.tableView.description]
	private lazy var alert = app.alerts[L10n.AlertAuth.title]

	// MARK: - ScreenObject methods

	/// Проверяет является ли текущий экран TodoList
	/// - Returns: сам объект self
	@discardableResult
	func isTodoList() -> Self {
		let navigationBarTitle = navigationBar.staticTexts[L10n.TodoList.title]
		assert(navigationBarTitle, [.exists], timeout: 10)

		return self
	}

	/// Возвращает количество секций в таблице
	/// - Returns: количество секций
	@discardableResult
	func numberOfSections() -> Int {
		assert(table, [.exists])
		let sections = table.otherElements.staticTexts

		return sections.count
	}

	/// Возвращает название секции
	/// - Parameter section: идекс секции
	/// - Returns: название секции
	@discardableResult
	func getTitleForHeaderIn(section: Int) -> Self {

		switch section {
		case 0:
			let header = table.otherElements.element(boundBy: 0)
			assert(header, [.exists])
			assert(header.staticTexts.firstMatch, [.contains(L10n.Task.uncompleted)])
		case 1:
			let header = table.otherElements.element(boundBy: 1)
			assert(header, [.exists])
			assert(header.staticTexts.firstMatch, [.contains(L10n.Task.completed)])
		default:
			let header = table.otherElements.element(boundBy: 3)
			assert(header, [.exists])
		}

		return self
	}

	/// Возвращает название  задания
	/// - Parameters:
	///   - section: индекс секции
	///   - row: индекс строки
	/// - Returns: название задания
	@discardableResult
	func getTitleForTaskIn(section: Int, row: Int) -> String {
		let header = table.otherElements.element(boundBy: section)
		let cell = app.cells[AccessibilityIdentifier.TodoList.cell(section: section, index: row).description]

		assert(header, [.exists])
		assert(cell, [.exists])
		assert(cell.staticTexts.firstMatch, [.contains("!!! \(L10n.Task.default)")])

		return cell.staticTexts.firstMatch.label
	}

	/// Меняет статус задания
	/// - Parameters:
	///   - section: индекс секции
	///   - row: индекс строки
	/// - Returns: сам объект self
	@discardableResult
	func changeTaskStatusIn(section: Int, row: Int) -> Self {
		let header = table.otherElements.element(boundBy: section)
		let cell = app.cells[AccessibilityIdentifier.TodoList.cell(section: section, index: row).description]

		assert(header, [.exists])
		assert(cell, [.exists])

		cell.tap()

		return self
	}
}
