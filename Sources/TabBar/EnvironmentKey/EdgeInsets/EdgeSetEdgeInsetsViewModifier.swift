//
//  EdgeSetEdgeInsetsViewModifier.swift
//
//
//  Created by Zijie on 19.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct EdgeSetEdgeInsetsViewModifier: ViewModifier {
    private var envEdgeInsets: Environment<EdgeInsets>
    private let path: WritableKeyPath<EnvironmentValues, EdgeInsets>
    private let edges: Edge.Set
    private let length: CGFloat?

    init(keyPath: WritableKeyPath<EnvironmentValues, EdgeInsets>, edges: Edge.Set, length: CGFloat?) {
        self.envEdgeInsets = Environment(keyPath)
        self.path = keyPath
        self.edges = edges
        self.length = length
    }

    func body(content: Content) -> some View {
        content.environment(path, new())
    }

    private func new() -> EdgeInsets {
        let old = envEdgeInsets.wrappedValue
        return .init(
            top: inset(.top, with: old),
            leading: inset(.leading, with: old),
            bottom: inset(.bottom, with: old),
            trailing: inset(.trailing, with: old)
        )
    }

    private func inset(_ edge: Edge, with oldInsets: EdgeInsets) -> CGFloat {
        edges.contains(.init(edge)) ? (length ?? 8) + oldInsets.length(of: edge) : oldInsets.length(of: edge)
    }
}

extension EdgeInsets {
    fileprivate func length(of edge: Edge) -> CGFloat {
        switch edge {
        case .top: return self.top
        case .leading: return self.leading
        case .bottom: return self.bottom
        case .trailing: return self.trailing
        }
    }
}
