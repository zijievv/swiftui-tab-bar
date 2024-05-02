//
//  TabBarHeightPreferenceKey.swift
//
//
//  Created by Zijie on 20.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

/// Tab bar height preference key
///
/// - Discussion:
///
///     Until at least and including iOS 16, a content view within a `NavigationView` cannot access the safe area insets
///     set by **`safeAreaInset(edge:alignment:spacing:content:)`** outside of the `NavigationView`. As a result, views
///     within a `NavigationView` in `TabBar` are partially obscured by the tab bar. To resolve this issue, you can
///     obtain the height of the tab bar outside of the `TabBar` using `TabBarHeightPreferenceKey`.
///
///     ```swift
///     struct ContentView: View {
///         @State private var tabBarHeight: CGFloat = 0
///         @State private var selection: Int = 0
///
///         var body: some View {
///             TabBar(selection: $selection) {
///                 NavigationView {
///                     HomeView()
///                         .safeAreaInset(edge: .bottom) { Color.clear.frame(height: tabBarHeight) }
///                 }
///                 .tabItem(0) { /* ... */ }
///
///                 NavigationView {
///                     AccountView()
///                         .safeAreaInset(edge: .bottom) { Color.clear.frame(height: tabBarHeight) }
///                 }
///                 .tabItem(1) { /* ... */ }
///             }
///             .onPreferenceChange(TabBarHeightPreferenceKey.self) { tabBarHeight = $0 }
///         }
///     }
///     ```
///
public struct TabBarHeightPreferenceKey: PreferenceKey {
    public static var defaultValue: CGFloat { .zero }
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
