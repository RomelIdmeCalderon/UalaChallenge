//
//  CoreDataManager.swift
//  ualaRomel
//
//  Created by Dudikoff Romel Idme Calderon on 20/11/24.
//

import CoreData


class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    private var context: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    func getCities() -> [CityEntity] {
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching cities: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveCities(cities: [City]) {
        for city in cities {
            if let existingCity = getCity(byId: city.id) {
                existingCity.name = city.name
                existingCity.country = city.country
                existingCity.latitude = city.coord.lat
                existingCity.longitude = city.coord.lon
                existingCity.isFavorite = city.isFavorite ?? false
            } else {
                let cityEntity = CityEntity(context: context)
                cityEntity.id = Int32(city.id)
                cityEntity.name = city.name
                cityEntity.country = city.country
                cityEntity.latitude = city.coord.lat
                cityEntity.longitude = city.coord.lon
                cityEntity.isFavorite = city.isFavorite ?? false
            }
        }
        do {
            try context.save()
        } catch {
            print("Error saving cities: \(error.localizedDescription)")
        }
    }
    
    func getCity(byId id: Int) -> CityEntity? {
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let cities = try context.fetch(fetchRequest)
            return cities.first
        } catch {
            print("Error fetching city by ID: \(error.localizedDescription)")
            return nil
        }
    }
  
    func toggleFavorite(cityId: Int) {
        if let city = getCity(byId: cityId) {
            city.isFavorite.toggle()
            do {
                try context.save()
            } catch {
                print("Error toggling favorite: \(error.localizedDescription)")
            }
        }
    }
}
