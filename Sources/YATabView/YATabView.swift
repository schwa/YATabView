import SwiftUI

public struct YATabView <SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    @Binding
    var selection: SelectionValue?

    var content: Content

    public var body: some View {
        VStack(spacing: 0) {
            YAPicker(selection: $selection) {
                ForEach(subviews: content) { subview in
                    subview.containerValues[keyPath: \.yaTabItem]
                        .tag(subview.containerValues.tag(for: SelectionValue.self))
                }
            }
            .labelsHidden()
            .pickerStyle(.segmented)
            .padding([.top, .bottom], 4)
            .focusable(interactions: .activate)

            Divider()

            ZStack {
                ForEach(subviews: content) { subview in
                    if subview.containerValues.tag(for: SelectionValue.self) == selection {
                        subview
                    } else {
                        subview.hidden()
                    }
                }
            }
        }
    }
}

public extension YATabView {
    init(selection: Binding<SelectionValue?>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
}

public extension YATabView {
    init(selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) where SelectionValue: Sendable {
        self._selection = selection.makeOptional()
        self.content = content()
    }
}

extension ContainerValues {
    @Entry
    var yaTabItem: AnyView?
}

public extension View {
    func yaTabItem<Item>(_ item: () -> Item) -> some View where Item: View {
        containerValue(\.yaTabItem, AnyView(item()))
    }
}

// MARK: -

/*
 extension YATabView where SelectionValue == Int {
 init(@ViewBuilder content: () -> Content) {
 fatalError()
 }
 }

 extension YATabView {
 init<C>(@XCTabContentBuilder<Never> content: () -> C) where SelectionValue == Never, Content == XCTabContentBuilder<Never>.Content<C>, C: XCTabContent {
 //        self.init(selection: .constant(nil), content: content)
 fatalError()
 }
 }


 @MainActor @preconcurrency
 public protocol XCTabContent<TabValue> {
 associatedtype TabValue: Hashable where TabValue == Body.TabValue
 associatedtype Body: TabContent

 @TabContentBuilder<TabValue>
 @MainActor @preconcurrency var body: Self.Body { get }
 }


 @resultBuilder
 struct XCTabContentBuilder <TabValue> where TabValue: Hashable {

 public struct Content<C> : View where C: XCTabContent {
 public var body: some View {
 fatalError()
 }
 }


 public static func buildExpression(_ content: some TabContent<TabValue>) -> some TabContent<TabValue> {
 content
 }


 public static func buildBlock(_ content: some TabContent<TabValue>) -> some TabContent<TabValue> {
 content
 }


 public static func buildIf(_ content: (some TabContent<TabValue>)?) -> (some TabContent<TabValue>)? {
 content
 }


 public static func buildEither<T, F>(first: T) -> _ConditionalContent<T, F> where TabValue == T.TabValue, T : TabContent, F : TabContent, T.TabValue == F.TabValue {
 fatalError()
 }

 public static func buildEither<T, F>(second: F) -> _ConditionalContent<T, F> where TabValue == T.TabValue, T : TabContent, F : TabContent, T.TabValue == F.TabValue {
 fatalError()
 }

 public static func buildLimitedAvailability<T>(_ content: T) -> AnyTabContent<T.TabValue> where T : TabContent {
 fatalError()
 }

 }
 */

#Preview {
    @Previewable @State
    var selection: Int? = 1

    YATabView(selection: $selection) {
        Text("String-1")
        .tag(1)
        .yaTabItem { Image(systemName: "1.circle") }
        Text("String-2")
        .tag(2)
        .yaTabItem { Image(systemName: "2.circle") }
    }
}

#Preview {
    @Previewable @State
    var selection: Int? = 1

    let tabView = YATabView(selection: $selection) {
        MeshGradient(width: 2, height: 2, points: [
            [0, 0], [1, 0], [0, 1], [1, 1]
        ], colors: [.red, .green, .blue, .yellow])
        .padding()
        .tag(1)
        .yaTabItem { Label("Document", systemImage: "document") }

        MeshGradient(width: 2, height: 2, points: [
            [0, 0], [1, 0], [0, 1], [1, 1]
        ], colors: [.purple, .orange, .pink, .brown])
        .padding()
        .tag(2)
        .yaTabItem { Label("Clock", systemImage: "clock") }

        MeshGradient(width: 2, height: 2, points: [
            [0, 0], [1, 0], [0, 1], [1, 1]
        ], colors: [.yellow, .green, .blue, .red])
        .padding()
        .tag(3)
        .yaTabItem { Label("Question", systemImage: "questionmark.circle") }
    }
    ContentUnavailableView("Your content here", image: "questionmark.circle")
        .inspector(isPresented: .constant(true)) {
            tabView
        }
}
