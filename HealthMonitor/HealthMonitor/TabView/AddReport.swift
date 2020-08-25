//
//  AddReport.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 25/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct AddReport: View {
    
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack() {
                    CardView()
                        
                    CardView()
                        
                    CardView()
                        
                    CardView()
                }
                .navigationBarTitle(Text("Nuovo Report"))
            }
        }
    }
}

struct AddReport_Previews: PreviewProvider {
    static var previews: some View {
        AddReport()
    }
}
