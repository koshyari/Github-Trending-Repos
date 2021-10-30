//
//  FetchRepos.swift
//  Trending-Repos
//
//  Created by Anshul Singh Koshyari on 30/10/21.
//

import UIKit

extension GithubVC {
    func fetchRepos(completion: @escaping () -> ()) {
        apiService.parseJSON(sort: sort_param, page: current_page) { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.errorView.isHidden = true
                let temp: [Items] = listOf.items
                self?.ans?.append(contentsOf: temp)
                print("Repo count: \(self?.ans?.count ?? 0)")
                completion()
            case .failure(let error):
                print("Error in processing JSON Data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.errorView.isHidden = false
                }
            }
        }
    }
}
