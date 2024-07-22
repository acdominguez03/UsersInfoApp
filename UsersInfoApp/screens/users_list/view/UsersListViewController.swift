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

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var floatingActionButton: UIButton!
    
    @IBOutlet weak var lbMessage: UILabel!

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Users"
        
        floatingActionButton.layer.masksToBounds = true
        floatingActionButton.layer.cornerRadius = 30

        setUpTableView()
        getUsersList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUsersOfDefaults()
        tableView.reloadData()
    }
    
    func getUsersList() {
        viewModel.$usersFiltered.sink { list in
            if(list.isEmpty) {
                self.lbMessage.text = "No hay usuarios todavía"
            } else {
                self.lbMessage.isHidden = true
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    func set(viewModel: UsersListViewModel) {
        self.viewModel = viewModel
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: UserCell.nibName, bundle: nil), forCellReuseIdentifier: UserCell.identifier)
    }
    
    @IBAction func floatingActionButtonTap(_ sender: Any) {
        
        navigationController?.pushViewController(AddUserWireframe().getViewController(), animated: true)
    }
}

extension UsersListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completion in
            self.viewModel.usersFiltered.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.viewModel.removeUser(index: indexPath.row)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        let updateAction = UIContextualAction(style: .destructive, title: nil) { _, _, completion in
            UpdateUserWireframe(userId: indexPath.row).push(navigation: self.navigationController)
            completion(true)
        }
        updateAction.image = UIImage(systemName: "pencil")
        updateAction.backgroundColor = .systemMint
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
        return config
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.usersFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = viewModel.usersFiltered[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell

        cell.ivFavoriteColor.layer.cornerRadius = 25
        cell.ivFavoriteColor.backgroundColor = Utils.shared.loadColor(colorComponents: element.favoriteColor)
        cell.lbName.text = element.name
        cell.lbCity.text = "Favorite city: " + element.favoriteCity

        return cell
    }
}

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = viewModel.usersFiltered[indexPath.row].id
        UserDetailWireframe(userId: userId).push(navigation: navigationController)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension UsersListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterList(searchText: searchText) {
            self.tableView.reloadData()
        }
    }
}
