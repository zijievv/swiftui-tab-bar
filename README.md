# TabBar

**TabBar** is a highly customizable tab bar view made in SwiftUI that functions similarly to TabView.

## Installation

Requirement: iOS 15.0+

This package can be installed using the [Swift Package Manager](https://www.swift.org/package-manager/).

### Usage

Similar to `TabView`, `TabBar` accepts a Binding value that conforms to `Hashable`.

```swift
import SwiftUI
import TabBar

struct ContentView: View {
    @State private var item: Int = 0

    var body: some View {
        TabBar(selection: $item) {
            HomeView()
                .tabItem(0) {
                    Image(systemName: item == 0 ? "house.fill" : "house")
                        .font(.title3)
                    Text("Home")
                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
                }
            MarksView()
                .tabItem(1) {
                    Image(systemName: item == 1 ? "star.fill" : "star")
                        .font(.title3)
                    Text("Marks")
                        .font(.system(.footnote, design: .rounded).weight(item == 1 ? .bold : .medium))
                }
            UserView()
                .tabItem(2) {
                    Image(systemName: item == 2 ? "person.fill" : "person")
                        .font(.title3)
                    Text("User")
                        .font(.system(.footnote, design: .rounded).weight(item == 2 ? .bold : .medium))
                }
        }
    }
}
```

`TabBar` provides a default style when no other modifiers are set.

<img src="Resources/Images/default-half.png" alt="default-half" style="zoom:50%;" />

With modifiers, it is easy to set the `TabBar`'s styles.

```swift
TabBar(selection: $item) {
    // ...
}
.tabBarFill(.regularMaterial)
.tabBarMargins(.vertical, 8)
.tabBarPadding(.vertical, 8)
.tabBarPadding(.horizontal, 16)
.tabBarShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
.tabBarShadow(radius: 1, y: 1)
```

<img src="Resources/Images/RoundedRectShadow-half.png" alt="RoundedRectShadow-half" style="zoom:50%;" />

`TabBar` accepts any fill that conforms to the `ShapeStyle` protocol.

```swift
TabBar(selection: $item) {
    // ...
}
.tabBarFill(.linearGradient(colors: [.orange, .yellow], 
                            startPoint: .top, endPoint: .bottom))
.tabBarMargins(.vertical, 8)
```

<img src="Resources/Images/defaultShapeGradient-half.png" alt="defaultShapeGradient-half" style="zoom:50%;" />

`TabBar` also accepts any background shape that conforms to the `Shape` protocol (e.g., Capsule).

```swift
TabBar(selection: $item) {
    // ...
}
.tabBarMargins(.vertical, 8)
.tabBarPadding(.vertical, 8)
.tabBarPadding(.horizontal, 16)
.tabBarShape(Capsule(style: .continuous))
.tabBarFill(.linearGradient(colors: [.yellow, .yellow.opacity(0.4)], 
                            startPoint: .top, endPoint: .bottom))
```

<img src="Resources/Images/CapsuleGradient-half.png" alt="CapsuleGradient-half" style="zoom:50%;" />
