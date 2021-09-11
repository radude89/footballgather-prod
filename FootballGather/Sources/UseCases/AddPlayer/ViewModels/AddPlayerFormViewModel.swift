//
//  AddPlayerFormViewModel.swift
//  AddPlayerFormViewModel
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import CoreModels

final class AddPlayerFormViewModel: ObservableObject {
    @Published var selectedPlayer = Player(name: "")
}
