//
//  FavoritesScreen.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import SwiftUI

struct FavoritesScreen: View {
    @State private var movies: [Movie] = []
    
    @State private var search: String = ""
    
    //TODO: load data from local storage
    var body: some View {
        NavigationStack {
            MovieListView(movies: $movies)
                .overlay {
                    if !search.isEmpty && movies.isEmpty {
                        Text("There is no \"\(search)\"")
                    } else if movies.isEmpty {
                        Text("No Favorite Movie")
                    }
                }
                .searchable(text: $search)
                .navigationTitle("Favorites")
        }
    }
}

struct FavoritesScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            FavoritesScreen()
        }
    }
}
