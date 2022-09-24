//
//  NetworkManager.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//
import Foundation
import SwiftyJSON

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    private init() { }
    
    func getGenres(completion: @escaping (Result<[GenreEntity], NetworkError>) -> Void) {
        
        let endpoint = EndPointFactory.shared
        
        let url: String = endpoint.configure(for: .genre)
        self.request(for: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.missingUrl))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decode = try JSON(data: data!)
                
                var genres: [GenreEntity] = []
                let items = decode["genres"].array
                
                items?.forEach({ item in
                    genres.append(GenreEntity(from: item))
                })
                
                completion(.success(genres))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
    }
    func getMovies(genre: String, page: Int, completion: @escaping (Result<[MovieEntity], NetworkError>) -> Void) {
        
        let endpoint = EndPointFactory.shared
        
        let url: String = endpoint.configure(for: .movieList(genre, page))
        self.request(for: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.missingUrl))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decode = try JSON(data: data!)
                var movies: [MovieEntity] = []
                let items = decode["results"].array
                
                items?.forEach({ item in
                    movies.append(MovieEntity(from: item))
                })
                
                completion(.success(movies))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
    }
    
    func getMovie(id: String, completion: @escaping (Result<MovieEntity, NetworkError>) -> Void) {
        let endpoint = EndPointFactory.shared
        
        let url: String = endpoint.configure(for: .movieDetails(id))
        
        self.request(for: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.missingUrl))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decode = try JSON(data: data!)
                print(decode)
//                var movies: MovieEntity =
//                let items = decode["results"].array
//                prin
//                completion(.success(movies))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
    }
    
    
    // MARK: NETWORK REQUEST
    func request(for url: String, with completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        //TODO: SHOW NEGATIVE ALERT
        guard let url = URL(string: url) else { return }
        
        let task = createTask(url: url, completion: completion)
        
        task.resume()
        
    }
    
    fileprivate func createTask(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        return URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { completion(data, response, error) }
        }
    }
}

enum NetworkError: String, Error {
    case missingUrl = "URL is missing"
    case decodingFailed = "Decoding failed"
    case badRequest = "Bad request"
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
