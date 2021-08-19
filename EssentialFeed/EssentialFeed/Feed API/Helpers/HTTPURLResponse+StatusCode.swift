//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by sherif kamal on 19/08/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
