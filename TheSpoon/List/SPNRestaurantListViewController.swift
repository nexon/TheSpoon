//
//  SPNRestaurantListViewController.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 14-11-22.
//

import UIKit

/// UI Class for showing the List of Restaurants
final class SPNRestaurantListViewController: UIViewController {

    // MARK: - Type Alias
    
    typealias Dependencies = HasRestaurantRepository & HasRestaurantStore
    
    // MARK: - Private Properties
    
    private var tableView: UITableView!
    private let controller: SPNRestaurantListController
    
    /// Initializer
    ///
    /// - Parameter dependencies: The Dependencies needed to start the Restaurant List
    init(dependencies:  Dependencies) {
        controller = SPNRestaurantListController(repository: dependencies.restaurantRepository)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        
        controller.read { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            case .failure(let error):
                strongSelf.showAlert(with: error)
            }
        }
    }
    
    // MARK: - Private Function(s)
    
    private func configureNavigationBar() {
        self.title = "The Spoon"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didPressSort(_:)))
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delaysContentTouches = false
        tableView.register(SPNRestaurantListTableViewCell.self,
                           forCellReuseIdentifier: String(describing: SPNRestaurantListTableViewCell.self))
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func sort(by option: SPNSortingOptions) {
        controller.sort(by: option)
        tableView.reloadData()
    }
    
    private func toggle(_ id: String) {
        controller.toggleFavorite(restaurant: id) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
    }
    
    @objc
    private func didPressSort(_ sender: UIBarButtonItem) {
        let viewController = SPNSortListViewController(options: SPNSortingOptions.allCases,
                                                       selectedOption: controller.sortingOption) { [weak self] option in
            self?.sort(by: option)
        }
        
        let navController = UINavigationController(rootViewController: viewController)
        
        viewController.modalPresentationStyle = .popover
        
        if let popover = viewController.popoverPresentationController {
            popover.barButtonItem = sender
            present(navController, animated: true, completion:nil)
        }
    }
}

// MARK: - <UITableViewDataSource>

extension SPNRestaurantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SPNRestaurantListTableViewCell.self),
                                                       for: indexPath) as? SPNRestaurantListTableViewCell,
              let entity = controller.item(at: indexPath.row) else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(with: entity) { [weak self] id in
            guard let strongSelf = self else { return }
            strongSelf.toggle(id)
        }
        return cell
    }
}
