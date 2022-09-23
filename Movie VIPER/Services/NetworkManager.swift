//
//  NetworkManager.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//
import Foundation

class NetworkManager: NSObject {
    var endPointManager: EndPointManager?
    
    func createRequest(for endPoint: EndPoints, with completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.endPointManager = EndPointManager(for: endPoint)
        
        //TODO: SHOW NEGATIVE ALERT
        guard let url = URL(string: endPointManager!.getURL()) else { return }
        
        let task = createTask(url: url, completion: completion)
        
        task.resume()
        
    }
    private func createTask(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        return URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { completion(data, response, error) }
        }
    }
}

enum NetworkError: String, Error {
    case missingUrl = "URL is missing"
    case decodingFailed = "Decoding failed"
    case authenticationError = "You need to be authenticated first or you not in Academy"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case userExist = "User already exist"
    case expiredToken = "Expired Token"
}
