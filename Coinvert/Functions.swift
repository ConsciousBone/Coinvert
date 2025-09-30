//
//  Functions.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import Foundation

private let apiURL = "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1"
private let currencyListURL = URL(string: apiURL + "/currencies.json")

struct Currency: Identifiable {
    let id: String      // the 3 character short thing (currencyCode)
    let name: String    // the actual name
}

func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
    URLSession.shared.dataTask(with: currencyListURL!) { data, response, error in
        var result: [Currency] = []
        
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if let data = data {
            if let dict = try? JSONDecoder().decode([String: String].self, from: data) {
                for (key, value) in dict {
                    if !value.isEmpty {
                        result.append(Currency(id: key, name: value))
                    }
                }
                
                result.sort {$0.name < $1.name}
            }
        }
        
        completion(.success(result))
    }.resume()
}

