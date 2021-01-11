//
//  SlotView.swift
//  Slots_swiftUi
//
//  Created by Sergey on 26.12.2020.
//

import SwiftUI

struct SlotView: View {
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .scaledToFill()
            .modifier(ImageModifier())
            .shadow(color: Color("ColorTransparentBlack"), radius: 4, x: 0.0, y: 6)
    }
}





struct SlotView_Previews: PreviewProvider {
    static var previews: some View {
        SlotView()
    }
}
