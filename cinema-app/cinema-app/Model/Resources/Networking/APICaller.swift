//
//  APICaller.swift
//  cinema-app
//
//  Created by FABRIZIO on 3/11/22.
//

import Foundation

struct APICaller {
    
    static let shared = APICaller()
    
    //MARK: - Métodos de clase
    func getDataFrom (category: categoryEnum, completion: @escaping (Result<[CategoryBody], Error>) -> Void) {
        guard let url = URL(string: prepareURLByCategory(category)) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                //let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let results = try JSONDecoder().decode(CategoryResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
        
    }
    
    
    private func prepareURLByCategory(_ category: categoryEnum) -> String {
        switch category {
        case .trendingMovies:
            return "\(Constants.baseURL)/3/trending/movie/day?api_key=\(ENV.SERVICE_API_KEY)"
        case .upcomingMovies:
            return "\(Constants.baseURL)/3/movie/upcoming?api_key=\(ENV.SERVICE_API_KEY)"
        case .topRated:
            return "\(Constants.baseURL)/3/movie/top_rated?api_key=\(ENV.SERVICE_API_KEY)"
        }
    }
}

extension APICaller {
    private struct Constants {
        static let baseURL = "https://api.themoviedb.org"
    }
    
    enum APIError: Error {
    case failedTogetData
    }
    
    enum categoryEnum: Int {
        case trendingMovies = 0
        case upcomingMovies = 1
        case topRated = 2
    }
}
