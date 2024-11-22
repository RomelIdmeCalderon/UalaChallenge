//
//  MainView.swift
//  ualaRomel
//
//  Created by Dudikoff Romel Idme Calderon on 20/11/24.
//
import SwiftUI
import MapKit

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var selectedCity: City? = nil
    @State private var isNavigationActive: Bool = false
    @State private var selectedCityId: Int? = nil

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        VStack {
                            TextField("Filter Cities", text: $viewModel.filterText)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            List(viewModel.filteredCities) { city in
                                CityCell(
                                    city: city,
                                    onFavoriteToggle: {
                                        viewModel.toggleFavorite(cityId: city.id)
                                    },  
                                    goToDetails: {
                                        selectedCity = city
                                        selectedCityId = city.id
                                        if geometry.size.width > geometry.size.height {
                                            isNavigationActive = false
                                        } else {
                                            isNavigationActive = true
                                        }
                                    }
                                )
                                .onAppear {
                                    if viewModel.filteredCities.last == city {
                                        viewModel.fetchCities(page: viewModel.currentPage)
                                    }
                                }
                                .background(
                                    geometry.size.width > geometry.size.height && selectedCityId == city.id ? Color.gray.opacity(0.3) : Color.clear
                                )
                            }
                        }
                        .frame(width: geometry.size.width > geometry.size.height ? geometry.size.width * 0.4 : geometry.size.width)

                        if geometry.size.width > geometry.size.height, let selectedCity = selectedCity {
                            MapView(city: selectedCity)
                                .frame(width: geometry.size.width * 0.6)
                        }
                    }
                    NavigationLink(
                        destination: selectedCity != nil
                            ? AnyView(MapView(city: selectedCity!))
                            : AnyView(EmptyView()),
                        isActive: $isNavigationActive,
                        label: { EmptyView() }
                    )
                    .hidden()
                }
                .onAppear {
                    if viewModel.cities.isEmpty {
                        viewModel.fetchCities(page: viewModel.currentPage)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MapView: View {
    let city: City

    var body: some View {
        VStack {
            // Mapa
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )))
            .frame(height: 300)

            Text("Map for \(city.name)")
                .font(.title)
                .padding()
        }
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
