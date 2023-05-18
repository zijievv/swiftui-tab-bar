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
import TabBar

struct ContentView: View {
    @State private var item: Int = 0

    var body: some View {
        TabBar(selection: $item) {
            Text("Home View")
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
        .tabBarMargins(vertical: 8)
        .tabBarPadding(horizontal: 16, vertical: 8)
        .tabBarShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .tabBarShadow(radius: 1, y: 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
