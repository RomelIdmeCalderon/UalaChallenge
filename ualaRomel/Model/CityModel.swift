//
//  CityModel.swift
//  ualaRomel
//
//  Created by Dudikoff Romel Idme Calderon on 20/11/24.
//
import Foundation

struct City: Identifiable, Codable, Equatable {
    let country: String
    let name: String
    let coord: Coordinates
    let _id: Int
    var isFavorite: Bool? = false

    struct Coordinates: Codable, Equatable {
        let lon: Double
        let lat: Double
    }

    var id: Int { _id }
}
