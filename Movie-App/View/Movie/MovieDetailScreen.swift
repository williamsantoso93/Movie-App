//
//  MovieDetailScreen.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import SwiftUI

struct MovieDetailScreen: View {
    @Binding var movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 8.0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(movie.title)
                            .font(.title)
                        
                        HStack(alignment: .center) {
                            Text(movie.releaseDate)
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            
                            Text(movie.voteAverage.formatted())
                        }
                        .font(.caption)
                    }
                    
                    Text(movie.overview)
                        .font(.caption)
                }
                .padding()
                
                if let image = movie.image {
                    TabView {
                        ForEach(image.backdrops, id:\.self) { image in
                            AsyncImage(url: URL(string: image.imageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                    .frame(height: 225)
                }
                
                if let image = movie.image {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(image.posters, id:\.self) { image in
                                AsyncImage(url: URL(string: image.imageUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            .frame(width: 100, height: 150)
                        }
                        .padding()
                    }
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if movie.image == nil {
                do {
                    let movieImages = try await Fetcher.getMovieImages(id: movie.id)
                    
                    Task { @MainActor in
                        movie.image = movieImages
                    }
                } catch {
                    
                }
            }
        }
    }
}

struct MovieDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let movieImages = MovieImages(backdrops: [MovieImageBackdrop(aspectRatio: 1.778, height: 2160, iso639_1: Optional("en"), filePath: "/8pjWz2lt29KyVGoq1mXYu6Br7dE.jpg", voteAverage: 5.312, voteCount: 1, width: 3840), MovieImageBackdrop(aspectRatio: 1.778, height: 2160, iso639_1: Optional("en"), filePath: "/2iNUodSKykQ4VtvtG280ntNy7hB.jpg", voteAverage: 5.172, voteCount: 1, width: 3840), MovieImageBackdrop(aspectRatio: 1.777, height: 1002, iso639_1: Optional("en"), filePath: "/nmei2VyCb7RYWPgH9ayvwMGXYww.jpg", voteAverage: 5.106, voteCount: 2, width: 1781), MovieImageBackdrop(aspectRatio: 1.778, height: 1080, iso639_1: Optional("en"), filePath: "/pYFNA112h90QtMDN5MGouTioL8M.jpg", voteAverage: 0.0, voteCount: 0, width: 1920), MovieImageBackdrop(aspectRatio: 1.778, height: 1080, iso639_1: Optional("en"), filePath: "/5qAFgeWIuSb1VrZlGdSuHb5xe2T.jpg", voteAverage: 0.0, voteCount: 0, width: 1920), MovieImageBackdrop(aspectRatio: 1.778, height: 1152, iso639_1: Optional("en"), filePath: "/wMHPWMjR4UcGDU054NIhP74lbHt.jpg", voteAverage: 0.0, voteCount: 0, width: 2048), MovieImageBackdrop(aspectRatio: 1.778, height: 1152, iso639_1: Optional("en"), filePath: "/oEJl2d0OdI9uURU3maAQHqj7P1h.jpg", voteAverage: 0.0, voteCount: 0, width: 2048), MovieImageBackdrop(aspectRatio: 1.778, height: 1080, iso639_1: Optional("en"), filePath: "/1QDFJNTNBNNDNHaiLiVI2APO2py.jpg", voteAverage: 0.0, voteCount: 0, width: 1920), MovieImageBackdrop(aspectRatio: 1.778, height: 1080, iso639_1: Optional("en"), filePath: "/tw67OlJ4tesaAw8R9i0Dq196KM3.jpg", voteAverage: 0.0, voteCount: 0, width: 1920)], id: 615656, logos: [MovieImagePoster(aspectRatio: 3.237, height: 1297, iso639_1: Optional("en"), filePath: "/xjzbSDGtnxnr2E1eXWTEcmVbuZR.png", voteAverage: 5.384, voteCount: 2, width: 4198), MovieImagePoster(aspectRatio: 3.237, height: 1297, iso639_1: Optional("en"), filePath: "/xfu52018OAqF3J6Oc7HQBYbOot6.png", voteAverage: 5.384, voteCount: 2, width: 4198), MovieImagePoster(aspectRatio: 3.233, height: 993, iso639_1: Optional("en"), filePath: "/wpv8lP3C5WEqov4niCwUInx8Crw.png", voteAverage: 5.246, voteCount: 2, width: 3210), MovieImagePoster(aspectRatio: 1.66, height: 482, iso639_1: Optional("en"), filePath: "/pmG7DR97uoEUSSimCp7QKkwlaUM.png", voteAverage: 5.106, voteCount: 2, width: 800)], posters: [MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg", voteAverage: 5.518, voteCount: 12, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/FQHtuf2zc8suMFE28RyvFt3FJN.jpg", voteAverage: 5.394, voteCount: 10, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/drCySAAAvegq1vQRGRqPKN9f00w.jpg", voteAverage: 5.388, voteCount: 4, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/uvYbo4eF3q6W06kpx5iDwC4jt6N.jpg", voteAverage: 5.264, voteCount: 8, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/nJPlTkgnWUWTzGfDm3DH0yWZoM5.jpg", voteAverage: 5.258, voteCount: 6, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/iNweHQSpBqiV4oTueFUGzhBqzO9.jpg", voteAverage: 5.252, voteCount: 4, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 1500, iso639_1: Optional("en"), filePath: "/b3pYeNq5URt7IADL9xlOadyMv73.jpg", voteAverage: 5.246, voteCount: 2, width: 1000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/mkMRoepr0sNMksQBlc4HSbye7fR.jpg", voteAverage: 5.18, voteCount: 3, width: 2000), MovieImagePoster(aspectRatio: 0.675, height: 1481, iso639_1: Optional("en"), filePath: "/kGMe8oqY2m8tWRFp3jjglmL7jnY.jpg", voteAverage: 5.18, voteCount: 3, width: 1000), MovieImagePoster(aspectRatio: 0.664, height: 1507, iso639_1: Optional("en"), filePath: "/3VEBy0YOa9LRfTXJTedltsc2CrY.jpg", voteAverage: 5.172, voteCount: 1, width: 1000), MovieImagePoster(aspectRatio: 0.666, height: 1229, iso639_1: Optional("en"), filePath: "/jhknTb0IgkNO5iXGAjOqU5aZ4Vq.jpg", voteAverage: 5.172, voteCount: 1, width: 819), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/4iMP9bYlsleqP5zhffi8eu1AI2w.jpg", voteAverage: 5.172, voteCount: 1, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 1425, iso639_1: Optional("en"), filePath: "/gn1NYCe3LBGFaeWJv2uFlUSFrdZ.jpg", voteAverage: 5.172, voteCount: 1, width: 950), MovieImagePoster(aspectRatio: 0.667, height: 1425, iso639_1: Optional("en"), filePath: "/yIRyyC7EXqOHAJjM29wAIbH1nQY.jpg", voteAverage: 5.172, voteCount: 1, width: 950), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/6K7P4RtBZmNKkituNdDuarFMh9R.jpg", voteAverage: 5.172, voteCount: 1, width: 2000), MovieImagePoster(aspectRatio: 0.658, height: 3000, iso639_1: Optional("en"), filePath: "/AkTPs7pjonA2CPUcWNfWeQQ5mO9.jpg", voteAverage: 5.172, voteCount: 1, width: 1973), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/b4nrJALNRBbhOVKnEpjEl8t2DGG.jpg", voteAverage: 5.128, voteCount: 6, width: 2000), MovieImagePoster(aspectRatio: 0.665, height: 907, iso639_1: Optional("en"), filePath: "/cft9sAu8HMqDd6zCnjXkypLFyCB.jpg", voteAverage: 5.128, voteCount: 6, width: 603), MovieImagePoster(aspectRatio: 0.667, height: 2048, iso639_1: Optional("en"), filePath: "/hImi8ZPWU1WCZ3IyPA6E9hP6rQp.jpg", voteAverage: 5.118, voteCount: 4, width: 1365), MovieImagePoster(aspectRatio: 0.667, height: 2048, iso639_1: Optional("en"), filePath: "/58qcnS8anwKGO3EivX0ibwrDIg2.jpg", voteAverage: 5.106, voteCount: 2, width: 1366), MovieImagePoster(aspectRatio: 0.667, height: 750, iso639_1: Optional("en"), filePath: "/qmOzB9kbWuBNdwlaXRklI3MJNs6.jpg", voteAverage: 5.106, voteCount: 2, width: 500), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/yphyMQn6KEUa4LoCYIuYZjv2M3O.jpg", voteAverage: 0.0, voteCount: 0, width: 2000), MovieImagePoster(aspectRatio: 0.679, height: 1236, iso639_1: Optional("en"), filePath: "/zDZcHcKOv1RVfmjVAgRHPv4bmkJ.jpg", voteAverage: 0.0, voteCount: 0, width: 839), MovieImagePoster(aspectRatio: 0.679, height: 1236, iso639_1: Optional("en"), filePath: "/7ZtGxAzYsEZZTUSfRtdDA4JCdi6.jpg", voteAverage: 0.0, voteCount: 0, width: 839), MovieImagePoster(aspectRatio: 0.679, height: 1236, iso639_1: Optional("en"), filePath: "/kFKkSUutiKaOWxo9fC2f6YkytDi.jpg", voteAverage: 0.0, voteCount: 0, width: 839), MovieImagePoster(aspectRatio: 0.667, height: 750, iso639_1: Optional("en"), filePath: "/6h3LZcgIyFgyLd7N2MDQhKIqDKZ.jpg", voteAverage: 0.0, voteCount: 0, width: 500), MovieImagePoster(aspectRatio: 0.667, height: 750, iso639_1: Optional("en"), filePath: "/nd2iDzOYXiITdAgG6w7x9WQ6nWG.jpg", voteAverage: 0.0, voteCount: 0, width: 500), MovieImagePoster(aspectRatio: 0.667, height: 750, iso639_1: Optional("en"), filePath: "/dARsjcAJfqtXP37iOPUS6b3XgP3.jpg", voteAverage: 0.0, voteCount: 0, width: 500), MovieImagePoster(aspectRatio: 0.667, height: 1500, iso639_1: Optional("en"), filePath: "/seHvZ6MgkmuVgwYywIGL1OnUjsU.jpg", voteAverage: 0.0, voteCount: 0, width: 1000)])
        let movie = Movie(id: 615656, adult: false, backdropPath: "/8pjWz2lt29KyVGoq1mXYu6Br7dE.jpg", originalLanguage: "en", originalTitle: "Meg 2: The Trench", overview: "An exploratory dive into the deepest depths of the ocean of a daring research team spirals into chaos when a malevolent mining operation threatens their mission and forces them into a high-stakes battle for survival.", popularity: 2237.141, posterPath: "/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg", releaseDate: "2023-08-02", title: "Meg 2: The Trench", video: false, voteAverage: 7.0, voteCount: 1701, image: movieImages)
        
        TabView {
            NavigationStack {
                MovieDetailScreen(movie: .constant(movie))
            }
        }
    }
}