//
//  UsersListViewController.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 29/5/24.
//

import UIKit
import Combine

class UsersListViewController: UIViewController {
    
    var viewModel: UsersListViewModel!
    
    private var cancellables: Set<AnyCancellable> = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var floatingActionButton: UIButton!
    
    @IBOutlet weak var lbMessage: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Users"
        
        floatingActionButton.layer.masksToBounds = true
        floatingActionButton.layer.cornerRadius = 30

        setUpCollectionView()
        getUsersList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUsersOfDefaults()
    }
    
    func getUsersList() {
        viewModel.$users.sink { list in
            if(list.isEmpty) {
                self.lbMessage.text = "No hay usuarios todavía"
            } else {
                self.lbMessage.isHidden = true
                self.collectionView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    func set(viewModel: UsersListViewModel) {
        self.viewModel = viewModel
    }
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(UINib(nibName: UserCell.nibName, bundle: nil), forCellWithReuseIdentifier: UserCell.identifier)
    }
    
    @IBAction func floatingActionButtonTap(_ sender: Any) {
        navigationController?.pushViewController(AddUserWireframe().getViewController(), animated: true)
    }
}

extension UsersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userId = viewModel.users[indexPath.row].id
        UserDetailWireframe(userId: userId).push(navigation: navigationController)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = viewModel.users[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.identifier, for: indexPath) as! UserCell

        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 25
        cell.ivFavoriteColor.tintColor = Extensions().loadColor(colorComponents: element.favoriteColor)
        cell.lbName.text = element.name
        cell.lbBirthdate.text = element.birthdate
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
