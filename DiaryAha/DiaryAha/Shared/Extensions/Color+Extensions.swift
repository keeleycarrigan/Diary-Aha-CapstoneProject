//
//  Colors.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/14/24.
//

import SwiftUI

extension Color {
    static var mainColor = orangePop
    static var secondaryColor = dripCoffee
    static var accentColor = freshBlue
    static var backgroundColor = pattyPan.mix(with: .white, by: 0.6)
}

extension UIColor {
    static var mainColor = UIColor(Color.mainColor)
    static var secondaryColor = UIColor(Color.secondaryColor)
    static var accentColor = UIColor(Color.accentColor)
    static var backgroundColor = UIColor(Color.backgroundColor)
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Color.barberry
            Color.orangePop
            Color.dripCoffee
            Color.backgroundColor
            Color.mainColor
            Color.secondaryColor
            Color.accentColor
        }
    }
}
