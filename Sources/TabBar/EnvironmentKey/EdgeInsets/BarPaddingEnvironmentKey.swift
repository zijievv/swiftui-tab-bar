//
//  BarPaddingEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarPaddingEnvironmentKey: EnvironmentKey {
    static var defaultValue: EdgeInsets? { nil }
}

extension EnvironmentValues {
    var tabBarPadding: EdgeInsets? {
        get { self[BarPaddingEnvironmentKey.self] }
        set { self[BarPaddingEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func tabBarPadding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View {
        modifier(EdgeSetEdgeInsetsViewModifier(keyPath: \.tabBarPadding, edges: edges, length: length))
    }

    public func tabBarPadding(_ edgeInsets: EdgeInsets) -> some View {
        modifier(EdgeInsetsViewModifier(keyPath: \.tabBarPadding, edgeInsets: edgeInsets))
    }
}
