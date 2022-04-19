//
//  ToontownProjectApp.swift
//  ToontownProject
//
//  Created by Mines Student on 4/13/22.
//

import SwiftUI

@main
struct ToontownProjectApp: App {
    @StateObject var toontownViewModel = ToontownViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(toontownViewModel: toontownViewModel)
        } .commands {
            CommandGroup(before: .saveItem){
                Button(action: loadData){
                    Text("Get Data")
                }
            }
            
        }
    }
    func loadData(){
        var _ = toontownViewModel.getPopulationData()
        var _ = toontownViewModel.getInvasionData()
        var _ = toontownViewModel.getSillyMeterData()
        var _ = toontownViewModel.getFieldOfficeData()
    }
}

