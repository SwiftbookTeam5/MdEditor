//
//  UploadFileRequestDTO.swift
//  MdEditor
//
//  Created by Александра Рязанова on 27.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import FileManagerPackage
import NetworkLayerPackage

struct UploadFileRequestDTO: INetworkRequest {
	var path = "api/files/upload"
	var method = HTTPMethod.post
	var parameters = Parameters.none

	init(file: File) {
		let boundary = UUID().uuidString
		if let data = getMultipartFormData(file: file, boundary: boundary) as? Data {
			self.parameters = .data(data, .multipart(boundary: boundary))
		}
	}
}

private extension UploadFileRequestDTO {

	func getMultipartFormData(file: File, boundary: String) -> NSMutableData? {
		guard let data = file.contentOfFile() else { return nil }

		let newline = "\r\n".data(using: .utf8)! // swiftlint:disable:this force_unwrapping

		let headers: [HeaderField] = [
			.contentDisposition(.multipart(name: "file", filename: file.name)),
			.contentType(.markdown)
		]

		let formData = NSMutableData()
		formData.append("--\(boundary)".data(using: .utf8)!) // swiftlint:disable:this force_unwrapping
		formData.append(newline)

		for field in headers {
			formData.append("\(field.key): \(field.value)".data(using: .utf8)!) // swiftlint:disable:this force_unwrapping
			formData.append(newline)
		}

		formData.append(newline)
		formData.append(data)
		formData.append(newline)

		formData.append("--\(boundary)--".data(using: .utf8)!) // swiftlint:disable:this force_unwrapping
		formData.append(newline)

		return formData
	}
}
