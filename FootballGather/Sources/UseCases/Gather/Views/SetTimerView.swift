//
//  SetTimerView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 17.12.2021.
//

import SwiftUI

struct SetTimerView: View {
    
    @State private var selectedMinutes = 0
    @State private var selectedSeconds = 2
    
    private let minutesInterval = [Int](0...60)
    private let secondsInterval = [Int](1..<60)
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                VStack {
                    Picker("Minutes", selection: $selectedMinutes) {
                        ForEach(minutesInterval, id: \.self)  { minutes in
                            Text("0\(minutes)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(
                        width: geometry.size.width / 2,
                        alignment: .center
                    )
                    .labelsHidden()
                    .clipped()
                    
                    Text("Minutes")
                }
                
                VStack {
                    Picker("Seconds", selection: $selectedSeconds) {
                        ForEach(secondsInterval, id: \.self)  { seconds in
                            Text("0\(seconds)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(
                        width: geometry.size.width / 2,
                        alignment: .center
                    )
                    .labelsHidden()
                    .clipped()
                    
                    Text("Seconds")
                }
            }
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}

struct SetTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimerView()
        
        SetTimerView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
