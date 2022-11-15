//
//  SPNRestaurantListViewController.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 14-11-22.
//

import UIKit

class SPNRestaurantListViewController: UIViewController {

    // MARK: - Private Properties
    
    private var tableView: UITableView!
    private var items: [SPNRestaurantDTO] = []
    private var store: SPNRestaurantStore = SPNRestaurantAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(SPNRestaurantListTableViewCell.self,
                           forCellReuseIdentifier: String(describing: SPNRestaurantListTableViewCell.self))
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        store.read(parameters: [:]) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let items):
                strongSelf.items = items
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
//        Task {
//            do {
//                items = try await SPNRestaurantAPI().read(parameters: [:])
//                tableView.reloadData()
//            } catch {
//                print("ERROR: \(error)")
//            }
//        }
    }
}

// MARK: - <UITableViewDataSource>

extension SPNRestaurantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SPNRestaurantListTableViewCell.self),
                                                       for: indexPath) as? SPNRestaurantListTableViewCell else { return UITableViewCell() }
    
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
}
