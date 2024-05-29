//
//  UsersListViewController.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 29/5/24.
//

import UIKit

class UsersListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var floatingActionButton: UIButton!
    
    let users = [
        UserEntity(name: "Andres", userBirthday: "10/08/2003", favoriteColor: UIColor.red, favoriteCity: "Sidney", favoriteNumber: 7, actualLocation: ""),
        UserEntity(name: "Ismael", userBirthday: "23/06/1998", favoriteColor: UIColor.blue, favoriteCity: "Rome", favoriteNumber: 7, actualLocation: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Users"
        
        floatingActionButton.layer.masksToBounds = true
        floatingActionButton.layer.cornerRadius = 30

        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(UINib(nibName: UserCell.nibName, bundle: nil), forCellWithReuseIdentifier: UserCell.identifier)
    }
    

    @IBAction func floatingActionButtonTap(_ sender: Any) {
        navigationController?.pushViewController(AddUserViewController(nibName: nil, bundle: nil), animated: true)
    }
}

extension UsersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let elementId = users[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = users[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.identifier, for: indexPath) as! UserCell

        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 25
        cell.ivFavoriteColor.tintColor = element.favoriteColor
        cell.lbName.text = element.name
        cell.lbBirthdate.text = element.userBirthday
        cell.lbFavoriteCity.text = "Favorite city: " + element.favoriteCity
        cell.lbFavoriteNumber.text = "Favorite number: " + String(element.favoriteNumber)
        
        return cell
    }
    
}

extension UsersListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) { }
}

extension UsersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        let size = (collectionView.frame.width - 30)
        return CGSize(width: size, height: 100)
    }
}
