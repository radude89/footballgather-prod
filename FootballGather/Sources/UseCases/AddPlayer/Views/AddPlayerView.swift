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
    
    private struct Selected {
        var name = ""
        var skill = ""
        var position = ""
    }
    
    @State private var selected: Selected = .init()
    
    private let skills = ["Rookie", "Amateur", "Professional"]
    private let positions = ["Goalkeeper", "Defender", "Midfielder", "Winger", "Forward"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    content: {
                        TextField("Name of the player", text: $selected.name)
                    },
                    header: {
                        Text("Player Details")
                    },
                    footer: {
                        Text("Choose a name for your player so that you recognize him/her later on. Please note you can have players with the same name.")
                    }
                )
                
                Section(
                    content: {
                        Picker("Skill", selection: $selected.skill) {
                            ForEach(skills, id: \.self) {
                                Text($0)
                            }
                        }
                        Picker("Position", selection: $selected.position) {
                            ForEach(positions, id: \.self) {
                                Text($0)
                            }
                        }
                    },
                    header:  {
                        Text("Skillset & position")
                    },
                    footer: {
                        Text("Make sure you balance your teams based on the skillset and position of your players.")
                    }
                )
                
                Section {
                    Button("Save", action: savePlayer)
                }
            }
            .navigationBarTitle("Add Player")
        }
        .accessibilityID(.addView)
    }
    
    private func savePlayer() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

// MARK: - Preview

struct AddPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerView()
    }
}
