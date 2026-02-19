//
//  TwoComponentsPickerView.swift
//  
//
//  Created by Radu Dan on 21.12.2021.
//

import SwiftUI

public struct TwoComponentsPickerView: View {
    
    private let dataSource: TwoComponentsPickerViewDataSource
    
    public init(dataSource: TwoComponentsPickerViewDataSource) {
        self.dataSource = dataSource
    }
    
    public var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(components) { component in
                    makePickerView(
                        labelled: component.name,
                        selection: component.$selectedValue,
                        values: component.values,
                        width: geometry.size.width / CGFloat(components.count)
                    )
                        .accessibilityIdentifier(component.accessibilityID)
                }
            }
        }
        .padding()
        .ignoresSafeArea()
    }
    
    private var components: [TwoComponentsPickerViewDataSource.Component] {
        [dataSource.components.first, dataSource.components.second]
    }
    
    private func makePickerView(
        labelled label: String,
        selection: Binding<String>,
        values: [String],
        width: CGFloat
    ) -> some View {
        VStack {
            Picker(label, selection: selection) {
                ForEach(values, id: \.self)  { value in
                    Text("\(value)")
                }
            }
            .pickerStyle(.wheel)
            .frame(width: width, alignment: .center)
            .labelsHidden()
            .clipped()
            
            Text(label)
        }
    }
    
}

// MARK: - Previews

struct TwoComponentsPickerView_Previews: PreviewProvider {
    private static let minutes = (0...90).map { "\($0)"}
    private static let seconds = (1..<60).map { "\($0)"}
    
    private static let minComponent = TwoComponentsPickerViewDataSource.Component(
        values: minutes,
        name: "Minutes",
        accessibilityID: "minutes-picker-view",
        selectedValue: .constant("0")
    )
    
    private static let secComponent = TwoComponentsPickerViewDataSource.Component(
        values: seconds,
        name: "Seconds",
        accessibilityID: "seconds-picker-view",
        selectedValue: .constant("0")
    )

    static var previews: some View {
        TwoComponentsPickerView(
            dataSource: .init((first: minComponent, second: secComponent))
        )
        
        TwoComponentsPickerView(
            dataSource: .init((first: minComponent, second: secComponent))
        )
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
