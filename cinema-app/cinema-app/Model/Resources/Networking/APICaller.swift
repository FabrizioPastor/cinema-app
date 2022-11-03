//
//  APICaller.swift
//  cinema-app
//
//  Created by FABRIZIO on 3/11/22.
//

import Foundation

struct APICaller {
    
    static let shared = APICaller()
    
    private struct Constants {
        let baseURL = "https://api.themoviedb.org"
    }
}
