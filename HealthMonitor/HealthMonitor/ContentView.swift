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
        
        VStack {
            HeaderView()
            
            Spacer()
            
            Text("Hello, World!")
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
