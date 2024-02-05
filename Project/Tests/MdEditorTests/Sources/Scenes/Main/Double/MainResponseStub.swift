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
		files: FileStub.files,
		actions: [.new, .open, .about]
	)
}

private enum FileStub {

	static var files: [MainModel.Response.File] = [
		MainModel.Response.File(title: L10n.File.default, color: FlatColor.Green.Fern),
		MainModel.Response.File(title: L10n.File.default, color: FlatColor.Green.Fern),
		MainModel.Response.File(title: L10n.File.default, color: FlatColor.Orange.NeonCarrot),
		MainModel.Response.File(title: L10n.File.default, color: FlatColor.Orange.NeonCarrot)
	]
}
