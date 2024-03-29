//
//  FilesRequestDTO.swift
//  MdEditor
//
//  Created by Александра Рязанова on 26.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import NetworkLayerPackage

struct FilesRequestDTO: INetworkRequest {
	var path = "api/files"
	var method = HTTPMethod.get
	var parameters = Parameters.none

	init(id: String? = nil) {
		if let id {
			path += "/\(id)"
		}
	}
}
