//
//  Modifiers.swift
//  Slots_swiftUi
//
//  Created by Sergey on 27.12.2020.
//

import SwiftUI


struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .scaledToFill()
            .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: 200, alignment: .center)
            .shadow(color: Color("ColorTransparentBlack"), radius: 4, x: 0.0, y: 6)
    }
}
