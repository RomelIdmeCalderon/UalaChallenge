//
//  CityModel.swift
//  ualaRomel
//
//  Created by Dudikoff Romel Idme Calderon on 20/11/24.
//
import Foundation
enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case unknownError
}

class NetworkManager {
    static let shared = NetworkManager()

    func fetchCities(page: Int, perPage: Int, completion: @escaping (Result<[City], NetworkError>) -> Void) {
        guard let url = URL(string: "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError))
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }
            do {
                let allCities = try JSONDecoder().decode([City].self, from: data)
                let startIndex = (page - 1) * perPage
                let endIndex = min(startIndex + perPage, allCities.count)
                let citiesForPage = Array(allCities[startIndex..<endIndex])
                completion(.success(citiesForPage))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
