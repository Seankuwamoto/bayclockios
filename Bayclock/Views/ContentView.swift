//
//  ContentView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        // the main view of the app.
        TabView{
            BlockList()
                .environmentObject(ModelData())
                .tabItem {
                    Image(systemName: "clock")
                    Text("Schedule")
                }
            MenuView()
                .tabItem {
                    Image(systemName: "menucard")
                    Text("Menu")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
            DeveloperView()
                .tabItem {
                    Image(systemName: "lock.iphone")
                    Text("Developer")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
        ContentView()
            .environmentObject(ModelData())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
