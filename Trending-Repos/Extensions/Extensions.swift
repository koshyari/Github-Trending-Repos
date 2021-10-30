//
//  Extensions.swift
//  Trending-Repos
//
//  Created by Anshul Singh Koshyari on 29/10/21.
//

import UIKit

extension GithubVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ans?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == ans?.count ?? 0 - 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "loading")
//            return cell!
//        }
//        else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TableViewCell
//
//            cell.configure(with: (ans?[indexPath.row])!)
//            return cell
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TableViewCell

        cell.configure(with: (ans?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedIdx == indexPath.row && self.isCollapsed == true {
            return CGFloat(Constants.expandedCellHeight)
        } else {
            return CGFloat(Constants.collapsedCellHeight)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuView.isHidden = true

        if self.selectedIdx == indexPath.row {
            self.isCollapsed = !self.isCollapsed
        } else {
            self.isCollapsed = true
        }
        
        self.selectedIdx = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

//Add icon to label
extension UILabel {
    func addLeading(image: UIImage, text:String) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        
        let string = NSMutableAttributedString(string: text, attributes: [:])
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }
}
