//
//  Mocks+ValueSpy.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import Foundation
import Combine

extension Mocks {
    
    final class ValueSpy<Value> {
        
        private(set) var values: [Value] = []
        private var cancellable: AnyCancellable?
        
        init(_ publisher: AnyPublisher<Value, Never>) {
            cancellable = publisher.sink(receiveValue: { [weak self] value in
                self?.values.append(value)
            })
        }
        
    }
    
}
