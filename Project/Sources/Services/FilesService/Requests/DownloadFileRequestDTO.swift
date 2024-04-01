//
//  DownloadFileRequestDTO.swift
//  MdEditor
//
//  Created by Александра Рязанова on 27.03.2024.
//  Copyright © 2024 SwiftbookTeam5. All rights reserved.
//

import Foundation
import NetworkLayerPackage

struct DownloadFileRequestDTO: INetworkRequest {
	var path = "api/files/download"
	var method = HTTPMethod.get
	var parameters = Parameters.none

	init(id: String) {
		path += "/\(id)"
	}
}
