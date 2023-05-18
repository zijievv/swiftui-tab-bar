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
    @Environment(\.tabBarSpacing) private var barSpacing
    @State private var items: [Selection] = []
    @State private var tabItemBuilders: [Selection: TabItemViewBuilderPreferenceKey<Selection>.BuilderWrapper] = [:]
    @State private var barContentHeight: CGFloat = 0
    @State private var barContentWidth: CGFloat = 0
    @Binding private var visibility: Visibility
    private let selection: TabItemSelection<Selection>
    private let content: () -> Content

    public init(
        selection: Binding<Selection>,
        visibility: Binding<Visibility> = .constant(.automatic),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = .init(item: selection)
        self._visibility = visibility
        self.content = content
    }

    public var body: some View {
        ZStack(content: content)
            .environmentObject(selection)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .if(isBarVisible) {
                $0.safeAreaInset(edge: .bottom, alignment: .center, spacing: barSpacing) {
                    MainBar(barContentHeight: $barContentHeight) {
                        ForEach(items, id: \.hashValue, content: tab(item:))
                    }
                }
                .overlay { SafeAreaBar(barContentHeight: $barContentHeight) }
            }
            .onPreferenceChange(TabItemPreferenceKey<Selection>.self) { self.items = $0 }
            .onPreferenceChange(TabItemViewBuilderPreferenceKey<Selection>.self) { self.tabItemBuilders = $0 }
            .onPreferenceChange(TabItemMaxHeightPreferenceKey.self) { self.barContentHeight = $0 }
            .onPreferenceChange(TabBarContentWidthPreferenceKey.self) { self.barContentWidth = $0 }
    }

    private var isBarVisible: Bool { visibility != .hidden }
    private var tabItemWidth: CGFloat { barContentWidth / CGFloat(items.count) }

    @ViewBuilder
    private func tab(item: Selection) -> some View {
        if let builder = tabItemBuilders[item]?.content {
            builder()
                .contentShape(Rectangle())
                .frame(width: tabItemWidth)
                .mesurementSize(of: \.height, to: TabItemMaxHeightPreferenceKey.self)
                .onTapGesture { selection.item = item }
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
        ZStack {
            backgroundBoard()
            HStack(spacing: 0, content: content)
                .offset(y: (barMargins.top - barMargins.bottom) / 2)
        }
        .padding(barShape == nil ? EdgeInsets(top: barPadding.top, leading: 0, bottom: 0, trailing: 0) : barPadding)
    }

    private var mainBarShape: any Shape { barShape ?? Rectangle() }

    private func backgroundBoard() -> some View {
        Color.clear
            .frame(height: barContentHeight)
            .frame(maxWidth: .infinity)
            .mesurementSize(of: \.width, to: TabBarContentWidthPreferenceKey.self)
            .padding(barMargins)
            .background {
                GeometryReader { geo in
                    AnyView(mainBarShape.fill(shapeStyle.in(filledRect(with: geo)), style: fillStyle))
                        .shadow(color: barShadow.color, radius: barShadow.radius, x: barShadow.x, y: barShadow.y)
                }
            }
    }

    private func filledRect(with geo: GeometryProxy) -> CGRect {
        CGRect(x: 0, y: 0, width: geo.size.width, height: geo.size.height + geo.safeAreaInsets.bottom)
    }
}

private struct SafeAreaBar: View {
    @Environment(\.tabBarShapeStyle) private var shapeStyle
    @Environment(\.tabBarFillStyle) private var fillStyle
    @Environment(\.tabBarMargins) private var barMargins
    @Environment(\.tabBarShape) private var barShape
    @Binding var barContentHeight: CGFloat

    var body: some View {
        if barShape == nil {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Spacer(minLength: 0)
                    Rectangle()
                        .fill(shapeStyle.in(fillRect(with: geo)), style: fillStyle)
                        .frame(height: geo.safeAreaInsets.bottom)
                }
                .ignoresSafeArea()
            }
        }
    }

    private var barHeight: CGFloat { barContentHeight + barMargins.top + barMargins.bottom }

    private func fillRect(with geo: GeometryProxy) -> CGRect {
        CGRect(x: 0, y: -barHeight, width: geo.size.width, height: geo.safeAreaInsets.bottom + barHeight)
    }
}
