//
//  BetCardView.swift
//  Slots_swiftUi
//
//  Created by Sergey on 27.12.2020.
//

import SwiftUI

struct BetCardView: View {
    //MARK:- PROPETIES
    @State var betNumber: String
    
    
    var body: some View {
        Text(betNumber)
            .textExtension()
            .frame(width: 90)
            .padding(5)
            .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
            .background(
            Capsule()
                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom))
            )
            .padding(3)
            .background(
            Capsule()
                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .bottom, endPoint: .top))
            )
    }
}

struct BetCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            BetCardView(betNumber: "40")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
