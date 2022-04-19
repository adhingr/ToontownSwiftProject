//
//  SillyMeterView.swift
//  ToontownProject
//
//  Created by Mines Student on 4/18/22.
//

import SwiftUI

struct myHeader: View {
    var body: some View {
        Text("Silly Meter")
            .bold()
    }
}

struct SillyMeterView: View {
    @Binding var sillymeterdata: SillyMeter
    var body: some View {
        VStack{
            myHeader()
            List(){
                Text("reward: \(sillymeterdata.rewards[0])")
                Text("reward: \(sillymeterdata.rewards[1])")
                Text("reward: \(sillymeterdata.rewards[2])")
            }
            if sillymeterdata.winner == true {
                Text("Winner: \(sillymeterdata.winnerString)")
            }
            Spacer()
        }
    }
}

/*
struct SillyMeterView_Previews: PreviewProvider {
    static var previews: some View {
        SillyMeterView()
    }
}
*/
