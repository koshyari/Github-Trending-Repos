//
//  LoadSubviews.swift
//  Trending-Repos
//
//  Created by Anshul Singh Koshyari on 30/10/21.
//

import UIKit

extension GithubVC {
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
    
    func loadErrorView() {
        retryButton.layer.borderWidth = 1
        retryButton.layer.cornerRadius = 4
        retryButton.layer.borderColor = UIColor.green.cgColor
        errorView.isHidden = true
    }
    
    func loadRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        table.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.ans?.removeAll()
        current_page = 1
        fetchRepos { [weak self] in
            self?.table.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    func loadAllViews() {
        loadTableView()
        loadMenuView()
        loadErrorView()
        loadRefreshControl()
    }
}
