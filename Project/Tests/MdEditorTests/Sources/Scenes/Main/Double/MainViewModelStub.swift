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
		items: MenuStub.menu
	)
}

private enum FileStub {

	static var files: [MainModel.ViewModel.Item] = [
		MainModel.ViewModel.Item.file(
			MainModel.ViewModel.RecentFile(previewText: L10n.File.default, fileName: L10n.File.default)
		),
		MainModel.ViewModel.Item.file(
			MainModel.ViewModel.RecentFile(previewText: L10n.File.default, fileName: L10n.File.default)
		),
		MainModel.ViewModel.Item.file(
			MainModel.ViewModel.RecentFile(previewText: L10n.File.default, fileName: L10n.File.default)
		),
		MainModel.ViewModel.Item.file(
			MainModel.ViewModel.RecentFile(previewText: L10n.File.default, fileName: L10n.File.default)
		)
	]
}

private enum MenuStub {

	static var menu: [MainModel.ViewModel.Item] = [
		MainModel.ViewModel.Item.menu(
			MainModel.ViewModel.MenuItem(title: L10n.Main.Menu.newFile,  item: .newFile)
		),
		MainModel.ViewModel.Item.menu(
			MainModel.ViewModel.MenuItem(title: L10n.Main.Menu.openFile,  item: .openFile)
		),
		MainModel.ViewModel.Item.menu(
			MainModel.ViewModel.MenuItem(title: L10n.Main.Menu.about,  item: .showAbout)
		)
	]
}
