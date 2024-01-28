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
	private lazy var loginButton = app.buttons[AccessibilityIdentifier.Login.buttonLogin.description]
	private lazy var table = app.tables[AccessibilityIdentifier.TodoList.tableView.description]
	
	// MARK: - ScreenObject methods
	
	/// Проверяет является ли текущий экран TodoList
	/// - Returns: сам объект self
	@discardableResult
	func isTodoList() -> Self {
		assert(loginButton, [.exists])
		loginButton.tap()
		assert(table, [.exists])
		
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
	func getTitleForHeaderIn(section: Int) -> String {
		let header = table.otherElements.element(boundBy: section)
		assert(header, [.exists])
		
		return header.staticTexts.firstMatch.label
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
