//
//  FilterSheet.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 08/09/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import NotificationCenter
import UserNotifications
import Foundation
import SwiftUI

class LocalNotificationManager: ObservableObject {
    
    lazy var state: Bool = false
    
    var notifications = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifice abilitate")
                self.state = true
            } else {
                print("Notitifiche non abilitate")
                self.state = false
            }
        }
    }
    
    
    func sendNotification(start: Date) ->(){
        
        //        removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Report Giornaliero"
        content.body = "Cosa aspetti? E' giunto il momento di aggiungere il report giornaliero!"
        content.sound = UNNotificationSound.default
        
        var hourStart = DateComponents()
        hourStart.hour = Calendar.current.component(.hour, from: start)
        hourStart.minute = Calendar.current.component(.minute, from: start)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: hourStart, repeats: true)
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        print("Notica mandata")
    }
    
}

struct FilterSheet: View {
    
    @ObservedObject var notificationManager = LocalNotificationManager()
    
    @Binding var showSheet : Bool
    @State var date = Date()
    
    var body: some View {
        NavigationView {
            VStack{
                if notificationManager.state {
                    VStack(alignment: .leading){
                        Text("Le notifiche sono attive.").font(.headline).padding(.top).padding(.leading)
                        Text("Per disattivarle va in Impostazioni > Notifiche > HealthMonitor").padding(.bottom).padding(.leading)
                    }
                    
                    CardViewData(contentData: AnyView(
                        VStack(alignment: .center) {
                            Text("Orario delle Notifiche")
                                .font(.title)
                            
                            Spacer()
                            
                            DatePicker("", selection: $date,displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .padding()
                                .frame(maxHeight: 100)
                            
                            Spacer()
                            
                        }
                    ))
                    VStack {
                        Button(action: {
                            withAnimation {
                                self.showSheet = false
                                self.notificationManager.sendNotification(start: self.date)
                            }
                        }) {
                            VStack(alignment: .center){
                                Text("Cambia l'orario")
                                    .font(.title)
                            }
                            .padding(.all)
                            .frame(width: 370.0, height: 70.0)
                            .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
                            .cornerRadius(14.0)
                            
                        }
                    }.padding()
                    
                } else {
                    VStack(alignment: .leading){
                        Text("Le notifiche sono disattive.").font(.headline).padding(.top).padding(.leading)
                        Text("Per attivarle va in Impostazioni > Notifiche > HealthMonitor").padding(.bottom).padding(.leading)
                    }
                    
                }
                Spacer()
            }
            .navigationBarTitle("Notifiche")
            .navigationBarItems(trailing: Button(action: {
                self.showSheet = false
            }) {
                Image(systemName: "x.circle.fill").font(.title)
            })
        }
    }
}
