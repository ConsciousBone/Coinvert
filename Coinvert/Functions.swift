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

func getCurrencyList(completion: @escaping ([Currency]) -> Void) { // pulls all currencies
    URLSession.shared.dataTask(with: currencyListURL!) { data, response, error in
        var result: [Currency] = []
        
        if let data = data {
            if let dict = try? JSONDecoder().decode([String: String].self, from: data) {
                for (key, value) in dict {
                    if !value.isEmpty { // ignores currencies with just the currencyCode
                        result.append(Currency(id: key, name: value))
                    }
                }
                
                result.sort {$0.name < $1.name} // alphabetical ordering
            }
        }
        
        completion(result)
    }.resume()
}

func convertCurrency(
    base: String,
    wanted: String,
    amount: Double,
    completion: @escaping (Double?) -> Void
) {
    let urlString = apiURL + "/currencies/\(base).json"
    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        var result: Double? = nil
        
        if let data = data {
            if let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] { // parse json
                if let baseDict = dict[base] as? [String: Double] {
                    if let rate = baseDict[wanted] {
                        result = amount * rate
                    }
                }
            }
        }
        
        completion(result)
    }.resume()
}

func fetchRates(base: String, completion: @escaping ([String: Double]) -> Void) { // for the conversion table in ValueView
    let url = URL(string: apiURL + "/currencies/\(base).json")!
    
    URLSession.shared.dataTask(with: url) {data, response, error in
        var result: [String: Double] = [:] // make blank dictionary
        
        if let data = data {
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] { // parse json
                if let baseDict = json[base] as? [String: Double] {
                    result = baseDict
                }
            }
        }
        completion(result)
    }.resume()
}
