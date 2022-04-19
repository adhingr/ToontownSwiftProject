//
//  PopulationView.swift
//  ToontownProject
//
//  Created by Mines Student on 4/13/22.
//

import SwiftUI

struct PopulationView: View {
    @Binding var population: Int
    var body: some View {
        VStack{
            Text("Total Population: \(population)")
                .foregroundColor(.green)
                .bold()
        }
    }
        
}

/*
struct PopulationView_Previews: PreviewProvider {
    static var previews: some View {
        PopulationView()
    }
}
 */
