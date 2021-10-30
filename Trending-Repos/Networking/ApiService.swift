//
//  apiService.swift
//  Trending-Repos
//
//  Created by Anshul Singh Koshyari on 28/10/21.
//

import Foundation

class ApiService {
    var dataTask: URLSessionDataTask?
    
    func parseJSON(page: Int, completion: @escaping(Result<Repo, Error>) -> Void) {
        let API = "https://api.github.com/search/repositories?q=android&per_page=50&sort=stars&page=\(page)&order=desc&since=daily"
        guard let url = URL(string: API) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
            }
    
            //Handle Empty Response
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            //Handle Empty Data
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            //Parse the Data
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Repo.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
}
