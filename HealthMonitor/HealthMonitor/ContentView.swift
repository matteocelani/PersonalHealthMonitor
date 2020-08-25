//
//  ContentView.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 21/06/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

            TabView {
               Summary()
                 .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Riepilogo")
                  }
                
                Calendar()
                .tabItem {
                   Image(systemName: "calendar")
                   Text("Calendario")
                }
                
                AddReport()
                .tabItem {
                   Image(systemName: "plus")
                   Text("Nuovo")
                }
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
