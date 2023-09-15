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
            
            Text("Search")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            Text("Saved")
                .tabItem {
                    Label("Saved", systemImage: "bookmark.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
