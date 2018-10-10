//
//  DataToDomainMapping.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

typealias UseCaseSuccesCallback<T: Decodable> = (T) -> Void
typealias UseCaseFailureCallback = (Error) -> Void

/// Protocol to Map Service Data to Domain Model Data
protocol DataToDomainMapping {
    func domainModelFor<T: Decodable>(data: Data?, error: Error?) throws -> T
}

extension DataToDomainMapping {
    
    func domainModelFor<T: Decodable>(data: Data?, error: Error?) throws -> T {
        do {
            let responseModel: T = try responseModelFor(data: data, error: error)
            return responseModel
        } catch {
            throw error
        }
    }
    
    // MARK: - Private Helpers
    
    private func responseModelFor<T: Decodable>(data: Data?, error: Error?) throws -> T {
        if let error = error {
            throw error
        }
        guard let data = data else {
            throw DomainMappingError.dataUnavailable(message: "Response data is unavailable/nil")
        }
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            return response
        } catch {
            throw DomainMappingError.dataNotDecodable(message: "Response data is not decodable.")
        }
    }
}

/// Data to Domain mapping error cases
enum DomainMappingError: Error {
    case dataUnavailable(message: String)
    case dataNotDecodable(message: String)
}
