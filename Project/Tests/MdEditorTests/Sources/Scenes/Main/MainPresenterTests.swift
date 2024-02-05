//
//  MainPresenterTests.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 04.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
@testable import MdEditor

final class MainPresenterTests: XCTestCase {

	// MARK: - Private properties

	private let viewController = MainViewControllerSpy()

	// MARK: - Internal Methods

	func test_present_withResponse_shouldBeRenderSuccess() {
		let sut = makeSut()
		let response = MainResponseStub.response

		sut.present(response: response)

		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.render(:)")
		XCTAssertTrue(viewController.isViewModel, "Нет данных MainModel.ViewModel")
	}
}

// MARK: - Private methods

private extension MainPresenterTests {

	func makeSut() -> MainPresenter {
		MainPresenter(viewController: viewController, openFileClosure: nil)
	}
}
