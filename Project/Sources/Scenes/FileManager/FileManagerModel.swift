//
//  FileManagerModel.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import FileManagerPackage

enum FileManagerModel {

	enum Request {
		case fileSelected(indexPath: IndexPath)
	}

	struct Response {
		let currentFile: File?
		let files: [File]
	}

	struct ViewModel {
		/// Название текущей папки
		let currentFolderName: String
		/// Список файлов для отображения
		let files: [File]

		struct File {
			let name: String
			let info: String
			let isFolder: Bool
		}
	}
}
