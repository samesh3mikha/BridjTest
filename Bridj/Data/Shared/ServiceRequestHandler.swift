//
//  ServiceRequestHandler.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/9/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

typealias ServiceRequestCompletionCallback = (Data?, Error?) -> Void

protocol ServiceRequestHandler: ServiceToUrlRequestMapping {
    func performServiceRequest(_ serviceRequest: ServiceRequestComponet,
                               serviceRequestCompletionCallback: @escaping ServiceRequestCompletionCallback)
}

extension ServiceRequestHandler {
    func performServiceRequest(_ serviceRequest: ServiceRequestComponet,
                               serviceRequestCompletionCallback: @escaping ServiceRequestCompletionCallback) {
        do {
            let urlRequest = try urlRequestFor(serviceRequestComponet: serviceRequest)
            let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, _, error in
                serviceRequestCompletionCallback(data, error)
            }
            task.resume()
        } catch {
            fatalError("Couldn't build URL request:  \(error.localizedDescription)")
        }
    }
}
