//
//  NameDetailsSectionViewModel.swift
//  NameDetailsSectionViewModel
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI

@MainActor
struct NameDetailsSectionViewModel {
    @Binding var playerName: String
    let isAddingPlayer: Bool
}
