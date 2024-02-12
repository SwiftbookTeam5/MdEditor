//
//  OpenFileModel.swift
//  MdEditor
//
//  Created by Александра Рязанова on 05.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import UIKit

enum OpenFileModel {

	enum Request {
		struct ItemSelected {
			let indexPath: IndexPath
		}
	}

	struct Response {
		let files: [File]

		struct File {
			let title: String
			let subTitle: String
			let isFolder: Bool
			let url: URL
		}
	}

	struct ViewModel {

		/// Список файлов для отображения
		let files: [File]

		struct File {
			let title: String
			let subTitle: String
			let image: UIImage
		}
	}
}
