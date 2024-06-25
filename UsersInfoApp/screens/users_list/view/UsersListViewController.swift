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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.usersFiltered.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            viewModel.removeUser(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.usersFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = viewModel.usersFiltered[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell

        cell.ivFavoriteColor.layer.cornerRadius = 5
        cell.ivFavoriteColor.backgroundColor = Extensions().loadColor(colorComponents: element.favoriteColor)
        cell.lbName.text = element.name

        return cell
    }
}

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = viewModel.usersFiltered[indexPath.row].id
        UserDetailWireframe(userId: userId).push(navigation: navigationController)
    }
}

extension UsersListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterList(searchText: searchText) {
            self.tableView.reloadData()
        }
    }
}
