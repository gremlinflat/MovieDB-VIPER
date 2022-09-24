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
    
    func getMovieList(genreId: String, page: Int, completion: @escaping (Result<[MovieEntity], NetworkError>) -> Void) {
        let endpoint = EndPointFactory.shared
        
        let url: String = endpoint.configure(for: .movieList(genreId, page))
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
    
    func getMovieDetail(id: String, completion: @escaping (Result<MovieEntity, NetworkError>) -> Void) {
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
                let movieDetails: MovieEntity = MovieEntity(from: decode)
                completion(.success(movieDetails))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
    }
    
    func getMovieTrailer(movieId: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let endpoint = EndPointFactory.shared
        
        let url: String = endpoint.configure(for: .movieTrailer(movieId))
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
                if let resultsList = decode.dictionary?["results"]?.array {
                    if resultsList.count > 0,  let trailerKey = resultsList[0].dictionary?["key"]?.string{
                        completion(.success(trailerKey))
                    } else {
                        completion(.failure(.decodingFailed))
                    }
                }
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
    }
    func getReviews(movieId: String, completion: @escaping (Result<[ReviewEntity], NetworkError>) -> Void) {
        let endpoint = EndPointFactory.shared
        
        let url: String = endpoint.configure(for: .movieReview(movieId))
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
                var reviews: [ReviewEntity] = []
                let items = decode["results"].array
                
                items?.forEach({ item in
                    reviews.append(ReviewEntity(from: item))
                })
                completion(.success(reviews))
                
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
