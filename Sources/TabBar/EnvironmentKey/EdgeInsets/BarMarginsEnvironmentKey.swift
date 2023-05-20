//
//  BarMarginsEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarMarginsEnvironmentKey: EnvironmentKey {
    static var defaultValue: EdgeInsets? { nil }
}

extension EnvironmentValues {
    var tabBarMargins: EdgeInsets? {
        get { self[BarMarginsEnvironmentKey.self] }
        set { self[BarMarginsEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func tabBarMargins(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View {
        modifier(EdgeSetEdgeInsetsViewModifier(keyPath: \.tabBarMargins, edges: edges, length: length))
    }

    public func tabBarMargins(_ edgeInsets: EdgeInsets) -> some View {
        modifier(EdgeInsetsViewModifier(keyPath: \.tabBarMargins, edgeInsets: edgeInsets))
    }
}
