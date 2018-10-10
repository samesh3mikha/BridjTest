//
//  ServiceRequestToUrlMapping.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/9/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

/// Protocol providing implementation for Mapping SeviceRequest to UrlRequest
protocol ServiceToUrlRequestMapping {
    
    /// Base URL of the backend service
    var baseUrl: URL { get }
    
    /// Builds urlRequest with provide serviceRequest: method, path, params,
    func urlRequestFor(serviceRequestComponet: ServiceRequestComponet) throws -> URLRequest
}

extension ServiceToUrlRequestMapping {
    
    var baseUrl: URL {
        return URL(string: "https://s3-ap-southeast-2.amazonaws.com")!
    }
    
    func urlRequestFor(serviceRequestComponet: ServiceRequestComponet) throws -> URLRequest {
        /// Add path to the base url
        var urlRequest: URLRequest
        do {
            urlRequest = try urlRequestWith(path: serviceRequestComponet.path)
        } catch {
            throw error
        }
        
        /// Set method of the urlRequest
        urlRequest.httpMethod = serviceRequestComponet.method.rawValue
        
        return urlRequest
    }
    
    // MARK: - Private Helpers
    
    private func urlRequestWith(path: String) throws -> URLRequest {
        guard var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else {
            throw ServiceRequestToUrlMappingError.invalidBaseUrl(message: "Base Url is invalid!")
        }
        components.path += path
        
        guard let url = components.url else {
            throw ServiceRequestToUrlMappingError.invalidURLPath(message: "Url path is invalid!")
        }
        return URLRequest(url: url)
    }
}

enum ServiceRequestToUrlMappingError: Error {
    case invalidBaseUrl(message: String)
    case invalidURLPath(message: String)
    case invalidParameters(message: String)
}
