//
//  InvasionView.swift
//  ToontownProject
//
//  Created by Mines Student on 4/18/22.
//

import SwiftUI

struct Header2: View {
    var body: some View {
        Text("Invasions")
            .bold()
    }
}



struct InvasionView: View {
    @Binding var invasions: [Invasion]
    var body: some View {
        Header2()
        Table(invasions){
            TableColumn("Invasion District", value: \.districtName)
            TableColumn("Cog Type", value: \.districtType)
            TableColumn("Progress", value: \.districtProgress)
            TableColumn("Estimated Time Remaining"){
                Text(String($0.timeRemaining) + " minutes")
            }
        }
    }
}

/*
struct InvasionView_Previews: PreviewProvider {
    static var previews: some View {
        InvasionView()
    }
}
 */
