//
//  ContentView.swift
//  ToontownProject
//
//  Created by Mines Student on 4/13/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var toontownViewModel: ToontownViewModel
    var body: some View {
        var _ = toontownViewModel.getPopulationData()
        VStack{
            PopulationView(population: $toontownViewModel.populationStuff.population)
        }
            .padding()
                //.frame(width: 400, height: 400, alignment: type)
    }
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 */
