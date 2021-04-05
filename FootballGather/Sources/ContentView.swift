//
//  ContentView.swift
//  Shared
//
//  Created by Radu Dan on 25.03.2021.
//

import SwiftUI
import Localizable

struct ContentView: View {
    var body: some View {
        Text(LocalizedText.hello)
            .padding()
            .accessibilityID(.hello)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
