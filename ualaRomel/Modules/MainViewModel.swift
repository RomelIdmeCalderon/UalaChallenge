//
//  MainViewModel.swift
//  ualaRomel
//
//  Created by Dudikoff Romel Idme Calderon on 20/11/24.
//
import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var filteredCities: [City] = []
    @Published var filterText: String = "" {
        didSet {
            applyFilter()
        }
    }
    @Published var isLoading: Bool = false
    @Published var isFetching: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    var currentPage = 1
    let citiesPerPage = 50
    
    init() {
        let savedCities = CoreDataManager.shared.getCities().map { cityEntity in
            City(
                country: cityEntity.country ?? "",
                name: cityEntity.name ?? "",
                coord: City.Coordinates(
                    lon: cityEntity.longitude,
                    lat: cityEntity.latitude
                ),
                _id: Int(cityEntity.id),
                isFavorite: cityEntity.isFavorite
            )
        }

        if savedCities.isEmpty {
            fetchCities(page: currentPage)
        } else {
            self.cities = savedCities
            self.filteredCities = self.cities
        }
    }
    
    func fetchCities(page: Int) {
        guard !isLoading && !isFetching else { return }

        isFetching = true
        isLoading = true

        NetworkManager.shared.fetchCities(page: page, perPage: citiesPerPage) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                self.isFetching = false
                switch result {
                case .success(let cities):
                    guard !cities.isEmpty else { return }
                    CoreDataManager.shared.saveCities(cities: cities)
                    let newCities = cities.map { city in
                        City(
                            country: city.country,
                            name: city.name,
                            coord: City.Coordinates(
                                lon: city.coord.lon,
                                lat: city.coord.lat
                            ),
                            _id: city.id,
                            isFavorite: CoreDataManager.shared.getCity(byId: city.id)?.isFavorite ?? false
                        )
                    }

                    self.cities.append(contentsOf: newCities)
                    self.filteredCities = self.cities.filter {
                        $0.name.contains(self.filterText) || self.filterText.isEmpty
                    }
                    self.currentPage += 1
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    private func applyFilter() {
        if filterText.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter {
                $0.name.lowercased().hasPrefix(filterText.lowercased())
            }
        }
    }
    
    func toggleFavorite(cityId: Int) {
        CoreDataManager.shared.toggleFavorite(cityId: cityId)

        let savedCities = CoreDataManager.shared.getCities().map { cityEntity in
            City(
                country: cityEntity.country ?? "",
                name: cityEntity.name ?? "",
                coord: City.Coordinates(
                    lon: cityEntity.longitude,
                    lat: cityEntity.latitude
                ),
                _id: Int(cityEntity.id),
                isFavorite: cityEntity.isFavorite
            )
        }

        self.cities = savedCities
        self.filteredCities = self.cities
    }
    
    
}
