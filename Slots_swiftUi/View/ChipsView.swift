//
//  ChipsView.swift
//  Slots_swiftUi
//
//  Created by Sergey on 27.12.2020.
//

import SwiftUI

struct ChipsView: View {
    //MARK:- PROPERTIES
   
    
    var body: some View {
        Image("gfx-casino-chips")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60, alignment: .center)
            
    }
}

struct ChipsView_Previews: PreviewProvider {
    static var previews: some View {
        ChipsView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
