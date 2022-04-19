//
//  FieldOfficeView.swift
//  ToontownProject
//
//  Created by Mines Student on 4/14/22.
//

import SwiftUI

struct Header3: View {
    var body: some View {
        Text("Field Offices")
            .bold()
    }
}


struct FieldOfficeView: View {
    @Binding var fieldOffices: [FieldOffice]
    var body: some View {
        Header3()
        Table(fieldOffices){
            TableColumn("Street", value: \.street)
            TableColumn("Difficulty"){
                Text(String($0.difficulty) + " star")
            }
            TableColumn("Annexes"){
                Text(String($0.annexes))
            }
            TableColumn("Open", value: \.open)
        }
    }
}
/*
struct FieldOfficeView_Previews: PreviewProvider {
    static var previews: some View {
        FieldOfficeView()
    }
}
*/
