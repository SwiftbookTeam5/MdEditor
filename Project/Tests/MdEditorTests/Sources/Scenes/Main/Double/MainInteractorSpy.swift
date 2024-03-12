//
//  MainInteractorSpy.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 04.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
@testable import MdEditor

final class MainInteractorSpy: IMainInteractor {

	// MARK: - Private properties

	private(set) var isCalledFetchData = false

	// MARK: - Internal Methods

	func fetchData() {
		isCalledFetchData = true
	}
	
	func performAction(request: MdEditor.MainModel.Request) {
		fatalError("Not implimented!")
	}
}
