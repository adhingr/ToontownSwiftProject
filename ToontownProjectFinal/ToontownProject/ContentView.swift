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
        //var _ = toontownViewModel.getPopulationData()
        var _ = toontownViewModel.getSillyMeterData()
        //var _ = toontownViewModel.getFieldOfficeData()
        //var _ = toontownViewModel.getInvasionData()
        
        
        HStack{
            VStack{
                SillyMeterView(sillymeterdata: $toontownViewModel.sillymeter)
                PopulationView(population: $toontownViewModel.populationStuff.population)
            
            }
            VStack{
                InvasionView(invasions: $toontownViewModel.invasionEachStuff)
                FieldOfficeView(fieldOffices: $toontownViewModel.fieldOfficeEachStuff)
            }
            VStack{
                Text("Group View Goes Here")
            }
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
