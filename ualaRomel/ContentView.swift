//
//  ContentView.swift
//  ualaRomel
//
//  Created by Dudikoff Romel Idme Calderon on 19/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Romel Idme Calderon\nTech Challenge").multilineTextAlignment(.center)
                NavigationLink(destination: MainView()) {
                    Text("Go to City List")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
