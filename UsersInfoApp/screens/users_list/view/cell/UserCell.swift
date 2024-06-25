//
//  UserCell.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 29/5/24.
//

import UIKit

class UserCell: UITableViewCell {
    
    static let identifier = "UserCellIdentifier"
    static let nibName = "UserCell"

    @IBOutlet weak var ivFavoriteColor: UIView!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
