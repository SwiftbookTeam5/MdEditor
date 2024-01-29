//
//  TodoListInteractorTests.swift
//  MdEditor
//
//  Created by Александра Рязанова on 15.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
import TaskManagerPackage
@testable import MdEditor

final class TodoListInteractorTests: XCTestCase {

	// MARK: - Properties

	private let presenter = TodoListPresenterSpy()
	private let sectionManager = SectionForTaskManagerAdapterMock()

	// MARK: - Methods

	func test_fetchData_shouldBeSuccess() {
		let sut = makeSut()

		sut.fetchData()

		XCTAssertTrue(presenter.isCalledPresent, "Не вызван presenter.present(:)")
	}

	func test_createTask_shouldBeSuccess() {
		let sut = makeSut()

		sut.createTask()

		XCTAssertTrue(presenter.isCalledCreateTask, "Не вызван presenter.createTask()")
	}
}

// MARK: - Private methods

private extension TodoListInteractorTests {

	func makeSut() -> TodoListInteractor {
		TodoListInteractor(presenter: presenter, sectionManager: sectionManager)
	}
}

final class SectionForTaskManagerAdapterMock: ISectionForTaskManagerAdapter {

	// MARK: - Properties

	private let currentSection: Section = .uncompleted

	// MARK: - Methods

	func getSections() -> [Section] {
		[currentSection]
	}

	func getSection(forIndex index: Int) -> Section {
		currentSection
	}

	func getTasksForSection(section: Section) -> [TaskManagerPackage.Task] {
		[]
	}
}

final class TodoListPresenterSpy: ITodoListPresenter {

	// MARK: - Properties

	private(set) var isCalledPresent = false
	private(set) var isCalledCreateTask = false

	// MARK: - Methods

	func present(response: TodoListModel.Response) {
		isCalledPresent = true
	}

	func createTask() {
		isCalledCreateTask = true
	}
}
