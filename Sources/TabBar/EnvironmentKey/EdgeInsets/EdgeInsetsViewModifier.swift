//
//  EdgeInsetsViewModifier.swift
//
//
//  Created by Zijie on 19.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct EdgeInsetsViewModifier: ViewModifier {
    private var envEdgeInsets: Environment<EdgeInsets?>
    private let path: WritableKeyPath<EnvironmentValues, EdgeInsets?>
    private let edgeInsets: EdgeInsets

    init(keyPath: WritableKeyPath<EnvironmentValues, EdgeInsets?>, edgeInsets: EdgeInsets) {
        self.envEdgeInsets = Environment(keyPath)
        self.path = keyPath
        self.edgeInsets = edgeInsets
    }

    func body(content: Content) -> some View {
        content.environment(path, newInsets())
    }

    private func newInsets() -> EdgeInsets {
        guard let old = envEdgeInsets.wrappedValue else { return edgeInsets }
        return .init(
            top: old.top + edgeInsets.top,
            leading: old.leading + edgeInsets.leading,
            bottom: old.bottom + edgeInsets.bottom,
            trailing: old.trailing + edgeInsets.trailing
        )
    }
}
