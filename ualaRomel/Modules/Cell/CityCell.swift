//
//  CityCell.swift
//  ualaRomel
//
//  Created by Dudikoff Romel Idme Calderon on 20/11/24.
//
import SwiftUI

struct CityCell: View {
    var city: City
    var onFavoriteToggle: () -> Void
    var goToDetails: () -> Void

    @State private var isFavorite: Bool

    init(city: City, onFavoriteToggle: @escaping () -> Void, goToDetails: @escaping () -> Void) {
        self.city = city
        self.onFavoriteToggle = onFavoriteToggle
        self.goToDetails = goToDetails
        _isFavorite = State(initialValue: city.isFavorite ?? false)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(city.name + " / " + city.country).font(.title)
                    .font(.headline)
                Text("Latitude: " + String(city.coord.lat)).font(.subheadline)
                    .font(.subheadline)
                Text("Longitude: " + String(city.coord.lat)).font(.subheadline)
                    .font(.subheadline)
            }
            Spacer()
            Button(action: {
                isFavorite.toggle()
                onFavoriteToggle()
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .gray)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            Button(action: {
                goToDetails()
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {}
    }
}
