//
//  ViewController.swift
//  Trending-Repos
//
//  Created by Anshul Singh Koshyari on 28/10/21.
//

import UIKit

class GithubVC: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var retryButton: UIButton!
    
    var apiService = ApiService()
    let refreshControl = UIRefreshControl()
    
    var repos: Repo?
    var ans: [Items]? = []
    
    //For Collapsing Cells
    var isCollapsed = true
    var selectedIdx = -1
    
    //For Pagination
    let total_pages = Constants.totalPages
    var current_page = 1
    
    //For Repo Sort Feature
    var sort_param = "stars"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableView()
        loadMenuView()
        loadErrorView()
        loadRefreshControl()
        fetchRepos { [weak self] in
            self?.table.reloadData()
        }
    }
    
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
    
 
    
    //IBAction functions
    @IBAction func menuTapped(_ sender: UIButton) {
        menuView.isHidden = !menuView.isHidden
    }
    
    @IBAction func retryTapped(_ sender: UIButton) {
        current_page = 1
        sort_param = "stars"
        fetchRepos { [weak self] in
            self?.table.reloadData()
        }
    }
    
    @IBAction func starsTapped(_ sender: UIButton) {
        guard sort_param != "stars" else {return}
        
        self.ans?.removeAll()
        sort_param = "stars"
        current_page = 1
        fetchRepos { [weak self] in
            self?.table.reloadData()
        }
//        ans?.sort { (item1: Items, item2: Items) in
//            return (item1.stargazers_count ?? 0) > (item2.stargazers_count ?? 0)
//        }
//        table.reloadData()
    }
    
    @IBAction func nameTapped(_ sender: UIButton) {
        guard sort_param != "name" else {return}
        
        self.ans?.removeAll()
        sort_param = "name"
        current_page = 1
        fetchRepos { [weak self] in
            self?.table.reloadData()
        }
//        ans?.sort { (item1: Items, item2: Items) in
//            return (item1.name ?? "") < (item2.name ?? "")
//        }
//        table.reloadData()
    }
}



