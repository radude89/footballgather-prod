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
    
    let viewModel: SetTimerViewModel
    
    var body: some View {
        NavigationView {
            TwoComponentsPickerView(
                dataSource: viewModel.makeDataSource()
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
