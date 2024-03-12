//
//  RecentFileManagerSpy.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 02.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
@testable import MdEditor

final class RecentFileManagerSpy: IRecentFileManager {

	// MARK: - Private properties
	
	private(set) var isCalledGetRecentFiles = false

	func getRecentFiles() -> [RecentFile] {
		isCalledGetRecentFiles = true

		return  [
			RecentFile(
				previewText: "# Markdown Example",
				url: Endpoints.documentExample,
				createDate: Date()
			),
		]
	}
}
