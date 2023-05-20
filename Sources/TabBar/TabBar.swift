//
//  TabBar.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

public struct TabBar<Selection, Content>: View where Selection: Hashable, Content: View {
    @Environment(\.tabItemSelectionHashValue) private var selectionHashValue
    @Environment(\.tabBarSpacing) private var barSpacing
    @State private var items: [Selection] = []
    @State private var tabItemBuilders: [Selection: TabItemViewBuilderPreferenceKey<Selection>.BuilderWrapper] = [:]
    @State private var barContentHeight: CGFloat = 0
    @State private var barContentWidth: CGFloat = 0
    @Binding private var selection: Selection
    @Binding private var visibility: Visibility
    private let content: () -> Content

    public init(
        selection: Binding<Selection>,
        visibility: Binding<Visibility> = .constant(.automatic),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selection = selection
        self._visibility = visibility
        self.content = content
    }

    public var body: some View {
        ZStack(content: content)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: barSpacing) {
                if visibility != .hidden {
                    MainBar(barContentHeight: $barContentHeight) {
                        ForEach(items, id: \.hashValue, content: tab(item:))
                    }
                }
            }
            .onPreferenceChange(TabItemPreferenceKey<Selection>.self) { self.items = $0 }
            .onPreferenceChange(TabItemViewBuilderPreferenceKey<Selection>.self) { self.tabItemBuilders = $0 }
            .onPreferenceChange(TabItemMaxHeightPreferenceKey.self) { self.barContentHeight = $0 }
            .onPreferenceChange(TabBarContentWidthPreferenceKey.self) { self.barContentWidth = $0 }
            .environment(\.tabItemSelectionHashValue, selection.hashValue)
    }

    private var tabItemWidth: CGFloat { barContentWidth / CGFloat(items.count) }

    @ViewBuilder
    private func tab(item: Selection) -> some View {
        if let builder = tabItemBuilders[item]?.content {
            builder()
                .contentShape(Rectangle())
                .frame(width: tabItemWidth)
                .mesurementSize(of: \.height, to: TabItemMaxHeightPreferenceKey.self)
                .onTapGesture { selection = item }
        }
    }
}

private struct MainBar<Content: View>: View {
    @Environment(\.tabBarShapeStyle) private var shapeStyle
    @Environment(\.tabBarFillStyle) private var fillStyle
    @Environment(\.tabBarMargins) private var barMargins
    @Environment(\.tabBarPadding) private var barPadding
    @Environment(\.tabBarShadow) private var barShadow
    @Environment(\.tabBarShape) private var barShape
    @Binding var barContentHeight: CGFloat
    let content: () -> Content

    var body: some View {
        ZStack(alignment: .top) {
            backgroundBoard()
            HStack(spacing: 0, content: content)
                .padding(barMargins)
        }
        .padding(isDefaultShape ? EdgeInsets(top: barPadding.top, leading: 0, bottom: 0, trailing: 0) : barPadding)
    }

    private var mainBarShape: any Shape { barShape ?? Rectangle() }
    private var isDefaultShape: Bool { barShape == nil }

    private func backgroundBoard() -> some View {
        Color.clear
            .frame(height: barContentHeight)
            .frame(maxWidth: .infinity)
            .mesurementSize(of: \.width, to: TabBarContentWidthPreferenceKey.self)
            .padding(barMargins)
            .background(alignment: .top) {
                GeometryReader { geo in
                    AnyView(mainBarShape.fill(shapeStyle, style: fillStyle))
                        .frame(height: isDefaultShape ? geo.size.height + geo.safeAreaInsets.bottom : geo.size.height)
                        .shadow(color: barShadow.color, radius: barShadow.radius, x: barShadow.x, y: barShadow.y)
                }
            }
    }
}
