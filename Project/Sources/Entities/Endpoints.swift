//
//  Endpoints.swift
//  MdEditor
//
//  Created by Kirill Leonov on 17.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

// swiftlint:disable force_unwrapping
// swiftlint:disable force_try

enum Endpoints {

	static var documents: URL = {
		try! FileManager.default.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: true
		)
	}()

	static var docs: URL = {
		Bundle.main.url(forResource: "Docs", withExtension: nil)!
	}()

	static var documentAbout: URL = {
		Bundle.main.url(
			forResource: "about",
			withExtension: "md"
		)!
	}()

	static var documentExample: URL = {
		Bundle.main.url(
			forResource: "Docs/Example",
			withExtension: "md"
		)!
	}()

	static var documentHeadings: URL = {
		Bundle.main.url(
			forResource: "Docs/Markdown/Headings",
			withExtension: "md"
		)!
	}()

	static var documentCode: URL = {
		Bundle.main.url(
			forResource: "Docs/Markdown/Code",
			withExtension: "md"
		)!
	}()

	static var documentLinks: URL = {
		Bundle.main.url(
			forResource: "Docs/Markdown/Links",
			withExtension: "md"
		)!
	}()
}

// swiftlint:enable force_try
// swiftlint:enable force_unwrapping
