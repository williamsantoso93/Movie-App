//
//  MovieDetailScreen.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import SwiftUI

struct MovieDetailScreen: View {
    @ObservedObject var viewModel: MovieViewModel
    
    private var movie: Movie {
        viewModel.movie
    }
    
    @State private var showStatus: Bool = false
    @State private var isSuccess: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: 8.0) {
                        VStack(alignment: .leading, spacing: 4) {
                            if let title = movie.title {
                                Text(title)
                                    .font(.title)
                            }
                            
                            
                            HStack(alignment: .center) {
                                if let releaseDate = movie.releaseDate {
                                    Text(releaseDate)
                                }
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                
                                if let voteAverage = movie.voteAverage {
                                    Text(voteAverage.formatted())
                                }
                            }
                            .font(.caption)
                        }
                        if let overview = movie.overview {
                            Text(overview)
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                
                if let image = movie.image {
                    if let backdrops = image.backdrops,
                       !backdrops.isEmpty {
                        TabView {
                            ForEach(backdrops, id:\.self) { image in
                                if let imageUrl = image.imageUrl {
                                    AsyncImage(url: URL(string: imageUrl)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .automatic))
                        .frame(height: 225)
                    }
                    
                    if let posters = image.posters,
                       !posters.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(posters, id:\.self) { image in
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
                            .padding(.horizontal)
                        }
                    }
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                if viewModel.isSaved {
                    isSuccess = viewModel.delete()
                } else {
                    isSuccess = viewModel.save()
                }
                showStatus = true
            } label: {
                Image(systemName: viewModel.isSaved ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
        }
        .sheet(isPresented: $showStatus) {
            AlertSavedStatusBottomSheet(isSuccess: isSuccess)
                .onTapGesture {
                    showStatus = false
                }
        }
        .onAppear {
            viewModel.fetchSaveStatus()
        }
        .task {
            if movie.image == nil {
                await viewModel.fetchImages()
            }
        }
    }
}

struct MovieDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            NavigationStack {
                MovieDetailScreen(viewModel: MovieViewModel(movie: Movie.fakeMovie()))
            }
        }
    }
}
