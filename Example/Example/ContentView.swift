//
//  ContentView.swift
//  Example
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI
import TabBarModule

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var item: Int = 0
    @State private var visibility: Visibility = .automatic
    @State private var text: String = ""

    var body: some View {
        TabBar(selection: $item, visibility: $visibility) {
            TextField("", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()
                .background(.brown)
                .tabItem(0) {
                    Image(systemName: item == 0 ? "house.fill" : "house")
                        .font(.title3)
                    Text("Home")
                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
                }
            Text("Marks View")
                .tabItem(1) {
                    Image(systemName: item == 1 ? "star.fill" : "star")
                        .font(.title3)
                    Text("Marks")
                        .font(.system(.footnote, design: .rounded).weight(item == 1 ? .bold : .medium))
                }
            Text("User View")
                .tabItem(2) {
                    Image(systemName: item == 2 ? "person.fill" : "person")
                        .font(.title3)
                    Text("User")
                        .font(.system(.footnote, design: .rounded).weight(item == 2 ? .bold : .medium))
                }
        }
        .tabBarFill(.regularMaterial)
        .tabBarMargins(.vertical, 8)
        .tabBarPadding(.horizontal, 16)
        .tabBarPadding(.vertical, 8)
        .tabBarShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .tabBarShadow(color: .init(.sRGBLinear, white: colorScheme == .dark ? 1 : 0, opacity: 0.33), radius: 1, y: 2)
        .tabBarTransition(.move(edge: .bottom).combined(with: .opacity))
        .tabBarAnimation { isTabBarVisible in
            isTabBarVisible ? .easeInOut(duration: 0.2).delay(0.15) : .linear(duration: 0.25)
        }
        .overlay(alignment: .top) {
            Button("Visibility \(visibilityDescription)", action: nextVisibility)
                .buttonStyle(.borderedProminent)
        }
    }

    private func nextVisibility() {
        switch visibility {
        case .automatic: visibility = .visible
        case .visible: visibility = .hidden
        case .hidden: visibility = .automatic
        }
    }

    private var visibilityDescription: String {
        switch visibility {
        case .automatic: return "automatic"
        case .visible: return "visible"
        case .hidden: return "hidden"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
