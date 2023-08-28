//
//  ContentView.swift
//  DarockKit_Previews
//
//  Created by WindowsMEMZ on 2023/8/22.
//

import AlertKit
import SwiftUI
import DarockKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                NStack {
                    VStack {
                        NeuButton(action: {
                            AlertKitAPI.present(title: "Test", subtitle: "Test Message", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                        }, label: "Test Button")
                    }
                }
                .navigationTitle("Buttons")
                .tag(1)
                .tabItem {
                    Label("Button", systemImage: "square")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        NStack {
            NeuInput("Placeholder", icon: "globe", text: .constant(""))
        }
        NStack {
            NeuButton(action: {}, label: "Test Button")
        }
        NStack {
            NeuText("Neumorphic Text")
        }
        NStack {
            NeuProgressView(value: 30, total: 100, foregroundColor: .blue, width: 300, height: 18)
        }
        NStack {
            VStack {
                NeuToggle("NToggle On", isOn: .constant(true), tint: .blue)
                NeuToggle("NToggle Off", isOn: .constant(false))
                NeuToggle(isOn: .constant(true), label: {
                    Text("NToggle With View Label")
                })
            }
        }
        
    }
}
