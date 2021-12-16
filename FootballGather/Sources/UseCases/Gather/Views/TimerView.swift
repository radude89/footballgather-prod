//
//  TimerView.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 08.12.2021.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        Text("\(viewModel.formattedTime)")
            .onAppear {
                viewModel.startTimer()
            }
    }
    
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: .init(remainingTimeInSeconds: 5))
    }
}
