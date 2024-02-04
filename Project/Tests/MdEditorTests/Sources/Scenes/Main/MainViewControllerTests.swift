//
//  MainViewControllerTests.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 04.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
@testable import MdEditor

final class MainViewControllerTests: XCTestCase {

	// MARK: - Private properties

	// swiftlint:disable implicitly_unwrapped_optional
	private var interactor: MainInteractorSpy!
	private var window: UIWindow!
	private var sut: MainViewController!
	// swiftlint:enable implicitly_unwrapped_optional

	// MARK: - Lifecyce

	override func setUp() {
		super.setUp()

		sut = MainViewController(collectionViewLayout: UICollectionViewLayout())
		interactor = MainInteractorSpy()
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

	// MARK: - Internal Methods

	func test_viewsIsReady_shouldBeFetchSuccess() {
		XCTAssertTrue(interactor.isCalledFetchData, "Не вызван interactor.fetchData()")
	}

	func test_render_withViewModel_shouldBeViewSuccess() {
		sut.render(viewModel: MainViewModelStub.viewModel)

		XCTAssertEqual(sut.collectionView.numberOfSections, 2, "Не верное количество секций")
	}
}
