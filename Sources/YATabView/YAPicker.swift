import SwiftUI

public struct YAPicker <Label, SelectionValue, Content>: View where Label: View, SelectionValue: Hashable, Content: View {
    private var label: Label?

    @Binding
    private var selection: SelectionValue?

    @Environment(\.yaPickerCellStyle)
    var cellStyle

    private var content: Content

    private init(label: Label?, selection: Binding<SelectionValue?>, content: Content) {
        self.label = label
        self._selection = selection
        self.content = content
    }

    public var body: some View {
        ViewThatFits {
            ForEach([16, 4], id: \.self) { spacing in
                HStack(spacing: spacing) {
                    ForEach(subviews: content) { subview in
                        if let tag = subview.containerValues.tag(for: SelectionValue?.self) {
                            view(for: tag, subview: subview)
                        }
                    }
                }
                .padding([.leading, .trailing], 4)
            }
        }
        .accessibilityRepresentation {
            Picker(selection: $selection, content: { content }, label: { label })
        }
    }

    @ViewBuilder
    func view(for tag: SelectionValue?, subview: Subview) -> some View {
        let binding = Binding<Bool> {
            tag == selection
        } set: { value, _ in
            if value == true {
                selection = tag
            } else {
                selection = nil
            }
        }
        let configuration = YAPickerCellStyleConfiguration(isOn: binding, content: .init(content: subview))
        AnyView(cellStyle.makeBody(configuration: configuration))
    }
}

public extension YAPicker {
    init(@ViewBuilder label: () -> Label, selection: Binding<SelectionValue?>, @ViewBuilder content: () -> Content) {
        self.init(label: label(), selection: selection, content: content())
    }

    init(@ViewBuilder label: () -> Label, selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) where SelectionValue: Sendable {
        self.init(label: label(), selection: selection.makeOptional(), content: content())}
}

public extension YAPicker where Label == Text {
    init(_ title: String, selection: Binding<SelectionValue?>, @ViewBuilder content: () -> Content) {
        self.init(label: Text(title), selection: selection, content: content())
    }
}

public extension YAPicker where Label == Never {
    init(selection: Binding<SelectionValue?>, @ViewBuilder content: () -> Content) {
        self.init(label: nil, selection: selection, content: content())
    }

    init(selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) where SelectionValue: Sendable {
        self.init(label: nil, selection: selection.makeOptional(), content: content())
    }
}

// MARK: -

public struct YAPickerCellStyleConfiguration {
    public struct Content: View {
        private var content: any View

        internal init(content: some View) {
            self.content = content
        }

        public var body: some View {
            AnyView(content)
        }
    }

    @Binding
    internal var isOn: Bool

    internal var content: Content

    internal init(isOn: Binding<Bool>, content: Content) {
        self._isOn = isOn
        self.content = content
    }
}

public protocol YAPickerCellStyle {
    associatedtype Body: View
    @ViewBuilder @MainActor /*@preconcurrency*/ func makeBody(configuration: Configuration) -> Body
    typealias Configuration = YAPickerCellStyleConfiguration
}

public struct DefaultYAPickerCellStyle: YAPickerCellStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Toggle(isOn: configuration.$isOn) {
            AnyView(configuration.content)
        }
        .toggleStyle(.button)
        .buttonStyle(.borderless)
        .labelStyle(.iconOnly)
        .symbolVariant(configuration.isOn ? .fill : .none)
    }
}

extension EnvironmentValues {
    @Entry
    var yaPickerCellStyle: (any YAPickerCellStyle) = DefaultYAPickerCellStyle()
}

public extension View {
    func yaPickerCellStyle(_ style: some YAPickerCellStyle) -> some View {
        environment(\.yaPickerCellStyle, style)
    }
}

// MARK: -

#Preview {
    @Previewable @State
    var optionalSelection: Int? = 1

    @Previewable @State
    var selection: Int = 1

    VStack {
        YAPicker(selection: $optionalSelection) {
            Label("Document", systemImage: "document").tag(1)
            Label("Clock", systemImage: "clock").tag(2)
            Label("Question", systemImage: "questionmark.circle").tag(3)
        }
        .padding()

        YAPicker(selection: $selection) {
            Label("Document", systemImage: "document").tag(1)
            Label("Clock", systemImage: "clock").tag(2)
            Label("Question", systemImage: "questionmark.circle").tag(3)
        }
        .padding()

        Picker("Picker", selection: $optionalSelection) {
            Label("Document", systemImage: "document").tag(1)
            Label("Clock", systemImage: "clock").tag(2)
            Label("Question", systemImage: "questionmark.circle").tag(3)
        }
        .padding()
    }
    .frame(width: 200)
}
