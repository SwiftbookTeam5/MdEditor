//
//  RecentFile.swift
//  MdEditor
//
//  Created by Kirill Leonov on 15.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

/// Модель описывающая последний используемый файл
struct RecentFile {
	let previewText: String
	let url: URL
	let createDate: Date
}
