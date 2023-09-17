//
//  BaseViewModel.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import Foundation

class BaseViewModel: ObservableObject {
    var fetcher: MovieFetcherProtocol = Fetcher()
    
    @Published private var _isLoading: Bool = false
    var isLoading: Bool {
        get {
            return _isLoading
        }
    }
    
    func loading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self._isLoading = isLoading
        }
    }
}
