//
//  TimerView.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 08.12.2021.
//

import SwiftUI

struct TimerView: View {
    
    @State private var controller = TimerController()
    @State private var newDate = Date()
    
    var body: some View {
        Text("Hello, World! \(newDate)")
//            .onAppear {
//                controller.startTimer()
//            }
//            .onReceive(controller.timer!) { date in
//                print(date)
//                newDate = date
//            }
    }
    
    func output(date: Date) {
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
