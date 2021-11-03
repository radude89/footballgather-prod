//
//  ConfirmPlayersViewController.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 02.11.2021.
//

import UIKit
import CoreModels
import Localizable

// MARK: - ConfirmPlayersViewController

final class ConfirmPlayersViewController: UIViewController {
    
    private var viewModel = ConfirmPlayersViewModel(players: [])
    
    private static let cellID = "ConfirmPlayersCell"
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: cellID
        )
        return tableView
    }()
    
    convenience init(players: [Player]) {
        self.init()
        viewModel = ConfirmPlayersViewModel(players: players)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
}

// MARK: - View setup

private extension ConfirmPlayersViewController {
    func setupViews() {
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.leadingAnchor
            .constraint(equalTo: view.leadingAnchor)
            .isActive = true
        
        tableView
            .topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        
        tableView
            .trailingAnchor
            .constraint(equalTo: view.trailingAnchor)
            .isActive = true
        
        tableView
            .bottomAnchor
            .constraint(equalTo: view.bottomAnchor)
            .isActive = true
    }
}

// MARK: - UITableViewDataSource

extension ConfirmPlayersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = makeCell()
        configureContent(of: cell, at: indexPath)
        return cell
    }
    
    private func makeCell() -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: Self.cellID)
        
        if cell == nil {
            cell = UITableViewCell(
                style: .default,
                reuseIdentifier: Self.cellID
            )
        }
        
        return cell
    }
    
    private func configureContent(
        of cell: UITableViewCell,
        at indexPath: IndexPath
    ) {
        var content = UIListContentConfiguration.cell()
        content.text = viewModel.rowTitle(at: indexPath)
        cell.contentConfiguration = content
    }

    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        viewModel.titleForHeaderInSection(section)
    }
    
    func tableView(
        _ tableView: UITableView,
        canMoveRowAt indexPath: IndexPath
    ) -> Bool {
        true
    }
    
    func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        viewModel.move(from: sourceIndexPath, to: destinationIndexPath)
    }
}
