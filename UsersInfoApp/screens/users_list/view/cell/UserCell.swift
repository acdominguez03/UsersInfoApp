//
//  UserCell.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 29/5/24.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    static let identifier = "UserCellIdentifier"
    static let nibName = "UserCell"

    
    @IBOutlet weak var ivFavoriteColor: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbFavoriteCity: UILabel!
    @IBOutlet weak var lbFavoriteNumber: UILabel!
    @IBOutlet weak var lbBirthdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
