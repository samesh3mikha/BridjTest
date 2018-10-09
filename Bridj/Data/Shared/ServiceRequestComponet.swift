//
//  ServiceRequestComponet.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/9/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case out = "PUT"
    case delete = "DELETE"
}

/// Protocols that provides the components or URLRequest
protocol ServiceRequestComponet {
    var method: HttpMethod { get }
    var path: String { get }
/* Parameters and Query not in use for the project
     var parameters: [String: String] { get }
     var query: String { get }
*/
}

// MARK: - Default ServiceRequestComponet implementation

//extension ServiceRequestComponet {
//    var method: HttpMethod { return .get }
//    var path: String { return "" }
///* Parameters and Query not in use for the project
//    var parameters: [String: String] { return [:] }
//    var query: String { return "" }
// */
//}


