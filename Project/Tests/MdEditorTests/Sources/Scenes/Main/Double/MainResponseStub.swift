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
		actions: ActionStub.actions
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

private enum ActionStub {

	static var actions: [MainModel.Response.Action] = [
		MainModel.Response.Action(title: L10n.Main.Actions.new, image: Asset.Icons.file.image),
		MainModel.Response.Action(title: L10n.Main.Actions.open, image: Asset.Icons.folder.image),
		MainModel.Response.Action(title: L10n.Main.Actions.about, image: Asset.Icons.about.image)
	]
}
