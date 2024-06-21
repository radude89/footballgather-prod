//
//  LayoutPinner.swift
//  
//
//  Created by Radu Dan on 08.11.2021.
//

import UIKit

@MainActor
public enum LayoutPinner {
    
    public static func top(
        _ view: UIView,
        to anotherView: UIView,
        usingSafeLayoutGuide: Bool = true,
        spacing: CGFloat = 0
    ) {
        let topAnchor = usingSafeLayoutGuide ?
        anotherView.safeAreaLayoutGuide.topAnchor :
        anotherView.topAnchor
        
        view
            .topAnchor
            .constraint(
                equalTo: topAnchor,
                constant: spacing
            )
            .isActive = true
    }
    
    public static func bottom(
        _ view: UIView,
        to anotherView: UIView,
        usingSafeLayoutGuide: Bool = false,
        spacing: CGFloat
    ) {
        let bottomAnchor = usingSafeLayoutGuide ?
        anotherView.safeAreaLayoutGuide.bottomAnchor :
        anotherView.bottomAnchor
        
        view
            .bottomAnchor
            .constraint(
                equalTo: bottomAnchor,
                constant: spacing
            )
            .isActive = true
    }
    
    public static func leading(
        _ view: UIView,
        to anotherView: UIView,
        spacing: CGFloat = 0
    ) {
        view
            .leadingAnchor
            .constraint(
                equalTo: anotherView.leadingAnchor,
                constant: spacing
            )
            .isActive = true
    }
    
    public static func trailing(
        _ view: UIView,
        to anotherView: UIView,
        spacing: CGFloat = 0
    ) {
        view
            .trailingAnchor
            .constraint(
                equalTo: anotherView.trailingAnchor,
                constant: spacing
            )
            .isActive = true
    }
    
}
