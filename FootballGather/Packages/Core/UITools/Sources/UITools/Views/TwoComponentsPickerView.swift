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
            HStack(spacing: 16) {
                ForEach(components) { component in
                    makePickerView(
                        labelled: component.name,
                        selection: component.$selectedValue,
                        values: component.values,
                        width: max(0, (geometry.size.width - 48) / CGFloat(components.count))
                    )
                    .accessibilityIdentifier(component.accessibilityID)
                }
            }
            .padding(16)
        }
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
        VStack(spacing: 12) {
            Picker(label, selection: selection) {
                ForEach(values, id: \.self)  { value in
                    Text("\(value)")
                        .font(.title3)
                        .fontWeight(.medium)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: width, alignment: .center)
            .labelsHidden()
            .clipped()
            
            Text(label)
                .font(.caption)
                .fontWeight(.semibold)
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background {
                    Capsule()
                        .fill(.tint.opacity(0.15))
                }
                .glassEffect(.regular, in: .capsule)
        }
        .padding(.vertical, 16)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.background.secondary)
        }
        .glassEffect(.regular, in: .rect(cornerRadius: 20))
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
