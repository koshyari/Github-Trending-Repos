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
    
    var apiService = ApiService()
    let refreshControl = UIRefreshControl()
    
    var repos: Repo?
    var ans: [Items]?
    var isCollapsed = true
    var selectedIdx = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableView()
        loadMenuView()
        loadRefreshControl()
        fetchRepos { [weak self] in
            self?.table.reloadData()
        }
    }
    
    func fetchRepos(completion: @escaping () -> ()) {
        apiService.parseJSON(page: 1) { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.ans = listOf.items
                //self?.ans?.append(contentsOf: listOf.items)
                completion()
            case .failure(let error):
                print("Error in processing JSON Data: \(error)")
                //Present NoInternetVC
            }
        }
    }
    
    func loadTableView() {
        table.dataSource = self
        table.delegate = self
        table.estimatedRowHeight = CGFloat(Constants.estimatedRowHeight)
        table.rowHeight = UITableView.automaticDimension
    }

    func loadMenuView() {
        menuView.isHidden = true
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowOffset = .zero
        menuView.layer.shadowRadius = 4
        menuView.layer.cornerRadius = 4
    }
    
    func loadRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        table.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        //self.ans?.removeAll()
        fetchRepos { [weak self] in
            self?.table.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    //IBAction functions
    @IBAction func menuTapped(_ sender: UIButton) {
        menuView.isHidden = !menuView.isHidden
    }
    
    @IBAction func starsTapped(_ sender: UIButton) {
        ans?.sort { (item1: Items, item2: Items) in
            return (item1.stargazers_count ?? 0) > (item2.stargazers_count ?? 0)
        }
        table.reloadData()
    }
    
    @IBAction func nameTapped(_ sender: UIButton) {
        ans?.sort { (item1: Items, item2: Items) in
            return (item1.name ?? "") < (item2.name ?? "")
        }
        table.reloadData()
    }
}



