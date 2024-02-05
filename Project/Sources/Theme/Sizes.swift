//
//  Sizes.swift
//  MdEditor
//
//  Created by Татьяна Исаева on 12.01.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
enum Sizes {

	static let borderWidth: CGFloat = 1
	static let topInset: CGFloat = 180.0

	enum Radius {
		static let small: CGFloat = 6
		static let medium: CGFloat = 10.0
	}

	enum Padding {
		static let half: CGFloat = 8
		static let normal: CGFloat = 16
		static let double: CGFloat = 32
	}

	enum L {
		static let width: CGFloat = 200
		static let height: CGFloat = 50
		static let widthMultiplier: CGFloat = 0.9
	}

	enum M {
		static let width: CGFloat = 100
		static let height: CGFloat = 40
	}

	enum S {
		static let width: CGFloat = 80
		static let height: CGFloat = 30
	}
}
// swiftlint:enable type_name
