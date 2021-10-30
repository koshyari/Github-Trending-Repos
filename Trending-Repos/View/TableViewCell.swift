//
//  TableViewCell.swift
//  Trending-Repos
//
//  Created by Anshul Singh Koshyari on 28/10/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var lang: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeImageCircular()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func makeImageCircular() {
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.bounds.width / 2
    }
    
    func configure(with model: Items) {
        self.userName.text = model.owner?.login
        self.repoName.text = model.name
        self.desc.text = model.description
        self.lang.text = model.language ?? "--"
        self.stars.addLeading(image: #imageLiteral(resourceName: "star-yellow-16"), text: String(model.stargazers_count ?? 0))
        self.forks.addLeading(image: #imageLiteral(resourceName: "fork-black-16"), text: String(model.forks_count ?? 0))
        
        let url = model.owner?.avatar_url
        if let data = try? Data(contentsOf: URL(string: url!)!) {
            self.userImage.image = UIImage(data: data)
        }
    }
    
}


