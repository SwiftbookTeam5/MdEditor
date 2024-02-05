//
//  AccessibilityIdentifier.swift
//  MdEditorUITests
//
//  Created by Александра Рязанова on 22.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

enum AccessibilityIdentifier {

	enum Login {
		case textFieldLogin
		case textFieldPass
		case buttonLogin

		var description: String {
			switch self {
			case .textFieldLogin:
				return "textFieldLogin"
			case .textFieldPass:
				return "textFieldPass"
			case .buttonLogin:
				return "buttonLogin"
			}
		}
	}

	enum TodoList {
		case tableView
		case cell(section: Int, index: Int)
		case section(index: Int)

		var description: String {
			switch self {
			case .cell(let section, let index):
				return "cell.\(section).\(index)"
			case .section(let index):
				return "cell.\(index)"
			case .tableView:
				return "tableView"
			}
		}
	}

	enum Main {
		case collectionView
		case cell(section: Int, index: Int)
		case section(index: Int)
		
		var description: String {
			switch self {
			case .cell(let section, let index):
				return "cell.\(section).\(index)"
			case .section(let index):
				return "cell.\(index)"
			case .collectionView:
				return "collectionView"
			}
		}
	}

	enum AboutApp {
		case textFieldAboutApp

		var description: String {
			switch self {
			case .textFieldAboutApp:
				return "textFieldAboutApp"
			}
		}
	}
}
