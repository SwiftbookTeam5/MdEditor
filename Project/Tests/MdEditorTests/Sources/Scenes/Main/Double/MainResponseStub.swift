//
//  MainResponseStub.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 04.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
@testable import MdEditor

enum MainResponseStub {

	static var response = MainModel.Response(
		recentFiles: RecentFileManagerSpy().getRecentFiles(),
		menu: [.newFile, .openFile, .showAbout]
	)
}
