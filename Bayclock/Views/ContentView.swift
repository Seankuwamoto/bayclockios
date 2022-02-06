//
//  ContentView.swift
//  Bayclock
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var isSecretActive = UserDefaults.standard.bool(forKey: "isSecretActive")
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        // the main view of the app.
        TabView {
            if(isSecretActive) {
                SecretView()
                    .tabItem {
                        Image(systemName: "lock")
                        Text("Secret")
                    }
            }
            HomeView()
                .environmentObject(ModelData())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
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
