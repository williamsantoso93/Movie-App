//
//  MovieRowView.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import SwiftUI

struct MovieRowView: View {
    var movie: Movie
    
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: movie.posterImageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 225)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .center) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Text(movie.voteAverage.formatted())
                    }
                    .font(.caption)
                    
                    Text(movie.title)
                        .font(.footnote)
                        .bold()
                        .lineLimit(1)
                }
                .padding(6)
                .foregroundColor(.primary)
                
                Spacer()
            }
        }
        .background {
            Color.primary.opacity(0.023)
                .shadow(radius: 50, x: 10, y: 10)
        }
        .cornerRadius(10)
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16),
        ]
        
        let movie = Movie(id: 615656, adult: false, backdropPath: "/8pjWz2lt29KyVGoq1mXYu6Br7dE.jpg", originalLanguage: "en", originalTitle: "Meg 2: The Trench", overview: "An exploratory dive into the deepest depths of the ocean of a daring research team spirals into chaos when a malevolent mining operation threatens their mission and forces them into a high-stakes battle for survival.", popularity: 2237.141, posterPath: "/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg", releaseDate: "2023-08-02", title: "Meg 2: The Trench", video: false, voteAverage: 7.0, voteCount: 1701)
        
        LazyVGrid(columns: columns, spacing: 16) {
            MovieRowView(movie: movie)
            MovieRowView(movie: movie)
        }
        .padding(16)
    }
}
