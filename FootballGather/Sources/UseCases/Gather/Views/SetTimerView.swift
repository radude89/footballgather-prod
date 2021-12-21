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
    
    @State private var selectedMinutes = "0"
    @State private var selectedSeconds = "2"
    
    private let minutesInterval = (0...60).map { "\($0)" }
    private let secondsInterval = (1..<60).map { "\($0)" }
    
    var body: some View {
        TwoComponentsPickerView(
            dataSource: .init(
                (
                    first: .init(
                        values: minutesInterval,
                        name: LocalizedString.minutes,
                        accessibilityID: .minutesPickerView,
                        selectedValue: $selectedMinutes
                    ),
                    second: .init(
                        values: secondsInterval,
                        name: LocalizedString.seconds,
                        accessibilityID: .secondsPickerView,
                        selectedValue: $selectedSeconds
                    )
                )
            )
        )
    }
}

struct SetTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimerView()
    }
}
