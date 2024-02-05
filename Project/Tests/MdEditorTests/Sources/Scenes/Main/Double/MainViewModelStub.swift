//
//  MainViewModelStub.swift
//  MdEditorTests
//
//  Created by Александра Рязанова on 04.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import XCTest
@testable import MdEditor

enum MainViewModelStub {

	static var viewModel = MainModel.ViewModel(
		sections: [
			SectionsStub.horizontal,
			SectionsStub.vertical
		]
	)
}

private enum SectionsStub {

	static var horizontal = MainModel.ViewModel.Section(
		type: .horizontal,
		items: FileStub.files
	)

	static var vertical = MainModel.ViewModel.Section(
		type: .vertical,
		items: ActionStub.actios
	)
}

private enum FileStub {

	static var files: [MainModel.ViewModel.Item] = [
		MainModel.ViewModel.Item.file(
			MainModel.ViewModel.File(title: L10n.File.default, color: FlatColor.Green.Fern)
		),
		MainModel.ViewModel.Item.file(
			MainModel.ViewModel.File(title: L10n.File.default, color: FlatColor.Green.Fern)
		),
		MainModel.ViewModel.Item.file(
			MainModel.ViewModel.File(title: L10n.File.default, color: FlatColor.Orange.NeonCarrot)
		),
		MainModel.ViewModel.Item.file(
			MainModel.ViewModel.File(title: L10n.File.default, color: FlatColor.Orange.NeonCarrot)
		)
	]
}

private enum ActionStub {

	static var actios: [MainModel.ViewModel.Item] = [
		MainModel.ViewModel.Item.action(
			MainModel.ViewModel.Action(title: L10n.Main.Actions.new, image: Asset.Icons.file.image)
		),
		MainModel.ViewModel.Item.action(
			MainModel.ViewModel.Action(title: L10n.Main.Actions.open, image: Asset.Icons.folder.image)
		),
		MainModel.ViewModel.Item.action(
			MainModel.ViewModel.Action(title:  L10n.Main.Actions.about, image: Asset.Icons.about.image)
		),
	]
}
