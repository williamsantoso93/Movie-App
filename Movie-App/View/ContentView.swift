//
//  ContentView.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieScreen()
                .tabItem {
                    Label("Movie", systemImage: "play.rectangle")
                }
            
            SearchScreen()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
            
            FavoritesScreen()
                .tabItem {
                    Label("Favorites", systemImage: "star.circle.fill")
                }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.systemBackground
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
