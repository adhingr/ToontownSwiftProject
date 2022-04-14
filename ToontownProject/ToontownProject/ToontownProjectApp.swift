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
        toontownViewModel.getPopulationData()
        toontownViewModel.getInvasionData()
        toontownViewModel.getSillyMeterData()
        toontownViewModel.getFieldOfficeData()
    }
}

