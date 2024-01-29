//
//  TodoListViewControllerTests.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 15.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
import TaskManagerPackage
@testable import MdEditor

final class TodoListViewControllerTests: XCTestCase {

	// MARK: - Properties

	// swiftlint:disable implicitly_unwrapped_optional
	private var interactor: TodoListInteractorSpy!
	private var window: UIWindow!
	private var sut: TodoListViewController!
	// swiftlint:enable implicitly_unwrapped_optional

	// MARK: - Lifecyce

	override func setUp() {
		super.setUp()

		sut = TodoListViewController()
		interactor = TodoListInteractorSpy()
		sut.interactor = interactor
		window = UIWindow()
		window.addSubview(sut.view)
		RunLoop.current.run(until: Date())
	}

	override func tearDown() {
		sut = nil
		window = nil
		interactor = nil

		super.tearDown()
	}

	// MARK: - Methods

	func test_viewsIsReady_shouldBeSuccess() {
		XCTAssertTrue(interactor.isCalledFetchData, "Не вызван interactor.fetchData()")
	}
}

final class TodoListInteractorSpy: ITodoListInteractor {

	// MARK: - Properties

	private(set) var isCalledFetchData = false

	// MARK: - Methods

	func fetchData() {
		isCalledFetchData = true
	}

	func didTaskSelected(request: MdEditor.TodoListModel.Request.TaskSelected) {
		fatalError("Not implimented!")
	}

	func createTask() {
		fatalError("Not implimented!")
	}
}
