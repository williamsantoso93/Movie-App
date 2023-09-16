//
//  MovieListView.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import SwiftUI

struct MovieListView: View {
    @Binding var movies: [Movie]
    
    var fetchMoreMovies: (() -> Void)?
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(movies.indices, id: \.self) { index in
                    NavigationLink {
                        MovieDetailScreen(movie: $movies[index])
                    } label: {
                        MovieRowView(movie: movies[index])
                            .onAppear {
                                if movies[index].id == movies.last?.id {
                                    fetchMoreMovies?()
                                }
                            }
                    }
                }
            }
            .padding(16)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movies: .constant([]))
    }
}
