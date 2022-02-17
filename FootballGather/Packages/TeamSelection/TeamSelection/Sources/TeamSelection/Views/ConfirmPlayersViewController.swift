//
//  ConfirmPlayersViewController.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 02.11.2021.
//

import UIKit
import SwiftUI
import UITools
import CoreModels
import Localizable

// MARK: - ConfirmPlayersViewController

final class ConfirmPlayersViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = ConfirmPlayersViewModel(players: [])
    private var gatherCoordinator: GatherCoordinatable = EmptyGatherCoordinator()
    
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
    
    private let startGatherButton = ButtonFactory.makeSystemButton(
        title: LocalizedString.startGather,
        isEnabled: false,
        accessibilityID: .startGatherButton,
        accessibilityHint: LocalizedString.startGatherHint,
        selector: #selector(startGather)
    )
    
    @objc private func startGather() {
        gatherCoordinator.startGather(
            from: self,
            playersTeams: viewModel.playersTeams,
            animated: true
        )
    }
    
    // MARK: - Public API
    
    convenience init(players: [Player], gatherCoordinator: GatherCoordinatable) {
        self.init()
        self.gatherCoordinator = gatherCoordinator
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
        tableView.delegate = self
        tableView.accessibilityIdentifier = AccessibilityID.confirmPlayersView.rawValue
    }
    
    func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(startGatherButton)
    }
    
    func setupConstraints() {
        setupTableViewConstraints()
        setupStartGatherButtonConstraints()
    }
    
    func setupTableViewConstraints() {
        LayoutPinner.top(tableView, to: view, usingSafeLayoutGuide: true)
        LayoutPinner.leading(tableView, to: view)
        LayoutPinner.trailing(tableView, to: view)
        
        tableView
            .bottomAnchor
            .constraint(equalTo: startGatherButton.topAnchor)
            .isActive = true
    }
    
    func setupStartGatherButtonConstraints() {
        LayoutPinner.leading(startGatherButton, to: view)
        LayoutPinner.trailing(startGatherButton, to: view)
        
        let bottomSpacing: CGFloat = 10
        LayoutPinner.bottom(startGatherButton, to: view, spacing: -bottomSpacing)
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
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: Self.cellID)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: Self.cellID)
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
        cell.separatorInset = .zero
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
        startGatherButton.isEnabled = viewModel.startGatherIsEnabled
    }
}

// MARK: - UITableViewDelegate

extension ConfirmPlayersViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        .none
    }
    
    func tableView(
        _ tableView: UITableView,
        shouldIndentWhileEditingRowAt indexPath: IndexPath
    ) -> Bool {
        false
    }
}
