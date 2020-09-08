//
//  FutureDay.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 08/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct FutureDay: View {
    @Binding var showSheet : Bool
    var body: some View {
        NavigationView {
                Text("Ops, non puoi aggiungere report futuri 😔")
        }
        .navigationBarItems(trailing: Button(action: {
            self.showSheet = false
        }) {
            Text("Chiudi").bold()
        })
    }
}
