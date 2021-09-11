//
//  AddPlayerView.swift
//  AddPlayerView
//
//  Created by Radu Dan on 07.09.2021.
//

import SwiftUI
import Localizable

struct AddPlayerView: View {
    
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        NavigationView {
            AddPlayerFormView(onSave: savePlayer)
                .navigationBarTitle(LocalizedString.addPlayer)
        }
        .accessibilityID(.addView)
    }
    
    private func savePlayer() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct AddPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerView()
    }
}
