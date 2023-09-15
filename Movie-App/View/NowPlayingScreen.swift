//
//  NowPlayingScreen.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import SwiftUI

struct NowPlayingScreen: View {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            
        }
    }
}

struct NowPlayingScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            NowPlayingScreen()
        }
    }
}
