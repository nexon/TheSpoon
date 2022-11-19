//
//  SPNSortListViewController.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 18-11-22.
//

import UIKit

enum SPNSortingOptions: CaseIterable {
    case name
    case rating
    
    var title: String {
        switch self {
        case .name:
            return "Name"
        case .rating:
            return "Rating"
        }
    }
}

final class SPNSortListViewController: UIViewController {
    // MARK: - Private Properties

    private var tableView: UITableView
    private let options: [SPNSortingOptions]
    private var selectedOption: SPNSortingOptions?
    private var onSelection: (_ selectedOption: SPNSortingOptions) -> Void
    
    
    // MARK: - Public Function(s)
    
    init(options: [SPNSortingOptions], selectedOption: SPNSortingOptions? = nil, onSelection: @escaping (_ selectedOption: SPNSortingOptions) -> Void) {
        self.options = options
        self.selectedOption = selectedOption
        self.onSelection = onSelection
        tableView = UITableView()
        
        super.init(nibName: nil, bundle: nil)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sort By"
    }
    
    // MARK: - Private Function(s)
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

// MARK: - <UITableViewDataSource>

extension SPNSortListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self),
                                                 for: indexPath)
        
        cell.textLabel?.text = options[indexPath.row].title
        cell.accessoryType = selectedOption == options[indexPath.row] ? .checkmark : .none
        return cell
    }
}

// MARK: - <UITableViewDelegate>

extension SPNSortListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newSelectedOption = options[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if newSelectedOption != selectedOption {
            selectedOption = newSelectedOption
            onSelection(newSelectedOption)
            tableView.reloadData()
        }
        
        dismiss(animated: true)
    }
}
