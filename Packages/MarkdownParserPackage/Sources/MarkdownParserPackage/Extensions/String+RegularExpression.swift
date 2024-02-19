//
//  String+RegularExpression.swift
//  MdEditor
//
//  Created by Александра Рязанова on 17.02.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation

extension String {

	func group(for regexPattern: String, group: Int = 1) -> String? {
		do {
			let text = self
			let regex = try NSRegularExpression(pattern: regexPattern)
			let range = NSRange(location: .zero, length: text.utf16.count)

			if let match = regex.firstMatch(in: text, range: range),
			   let group = Range(match.range(at: group), in: text) {
				return String(text[group])
			}
		} catch {
			return nil
		}

		return nil
	}
}
