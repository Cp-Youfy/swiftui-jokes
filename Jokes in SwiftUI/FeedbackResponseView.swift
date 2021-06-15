//
//  FeedbackResponseView.swift
//  Jokes in SwiftUI
//
//  Created by rgs on 5/6/21.
//

import SwiftUI

struct FeedbackResponseView: View {
    var isPositive: Bool
    
    var body: some View {
        VStack {
            Image(isPositive ? "happy" : "sad") // If isPositive, happy, else sad
                .resizable()
                .aspectRatio(
                    contentMode: .fit)
            Text(isPositive ? "Yay! Pommycat is happy" : "Rawr >:(, no cookies for you today")
                .padding()
        }
    } // ? : -- Ternary operator
}

struct FeedbackResponseView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackResponseView(isPositive: true)
    }
}
