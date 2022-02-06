//
//  ContentView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import SwiftUI

// the main view of the app.
struct ContentView: View {
    // imports the model data (schedule) from ModelData.swift
    @EnvironmentObject var modelData: ModelData
    @State private var isSecretActive = UserDefaults.standard.bool(forKey: "isSecretActive")
    // Updates the view once every second
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {

        TabView {
            if(isSecretActive) {
                SecretView()
                    .tabItem {
                        Image(systemName: "lock")
                        Text("Secret")
                    }
            }
            // Homepage with current block and other info
            HomeView()
                // passes in the schedule data to the view
                .environmentObject(ModelData())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            // Schedule page with all of your blocks for the current day
            BlockList()
                .environmentObject(ModelData())
                .tabItem {
                    Image(systemName: "clock")
                    Text("Schedule")
                }
            // View where you can see the menu for the month
            MenuView()
                .tabItem {
                    Image(systemName: "menucard")
                    Text("Menu")
                }
            // View where you can change various settings such as block color and compressed mode
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
            // Temporarily disabled.
//            DeveloperView()
//                .tabItem {
//                    Image(systemName: "lock.iphone")
//                    Text("Developer")
//                }
        }
        .onReceive(timer) { _ in
            isSecretActive = UserDefaults.standard.bool(forKey: "isSecretActive")
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
