//
//  TwoComponentsPickerViewDataSource.swift
//  
//
//  Created by Radu Dan on 21.12.2021.
//

import SwiftUI

public struct TwoComponentsPickerViewDataSource {
    public let components: (first: Component, second: Component)
    
    public init(_ components: (first: Component, second: Component)) {
        self.components = components
    }
}

extension TwoComponentsPickerViewDataSource {
    public struct Component: Identifiable {
        public let id = UUID()
        public let values: [String]
        public let name: String
        public let accessibilityID: String
        
        @Binding public var selectedValue: String
        
        public init(
            values: [String],
            name: String,
            accessibilityID: String,
            selectedValue: Binding<String>
        ) {
            self.values = values
            self.name = name
            self.accessibilityID = accessibilityID
            _selectedValue = selectedValue
        }
    }
}

extension TwoComponentsPickerViewDataSource.Component: Equatable {
    public static func == (
        lhs: TwoComponentsPickerViewDataSource.Component,
        rhs: TwoComponentsPickerViewDataSource.Component
    ) -> Bool {
        lhs.id == rhs.id
    }
}
