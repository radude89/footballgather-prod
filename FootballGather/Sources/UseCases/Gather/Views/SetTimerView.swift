//
//  SetTimerView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 17.12.2021.
//

import SwiftUI
import UITools
import Localizable

struct SetTimerView: View {
    
    @State private var selectedMinutes: String
    @State private var selectedSeconds: String
    
    let viewModel: SetTimerViewModel
    
    init(
        viewModel: SetTimerViewModel,
        selectedMinutes: String = "10",
        selectedSeconds: String = "00"
    ) {
        self.viewModel = viewModel
        self.selectedMinutes = selectedMinutes
        self.selectedSeconds = selectedSeconds
    }
    
    var body: some View {
        NavigationView {
            TwoComponentsPickerView(
                dataSource: viewModel.makeDataSource(
                    selectedMinutes: $selectedMinutes,
                    selectedSeconds: $selectedSeconds
                )
            )
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(LocalizedString.done) {}
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(LocalizedString.cancel) {}
                    }
                }
        }
    }
}

struct SetTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimerView(viewModel: .init())
    }
}
