import SwiftUI

public struct YAPicker <Label, SelectionValue, Content>: View where Label: View, SelectionValue: Hashable, Content: View {

    private var label: Label?

    @Binding
    private var selection: SelectionValue?

    private var content: Content

    private init(label: Label?, selection: Binding<SelectionValue?>, content: Content) {
        self.label = label
        self._selection = selection
        self.content = content
    }

    public var body: some View {
        HStack(spacing: 16) {
            ForEach(subviews: content) { subview in
                if let tag = subview.containerValues.tag(for: SelectionValue?.self) {
                    let binding = Binding<Bool> {
                        tag == selection
                    } set: { value, _ in
                        if value == true {
                            selection = tag
                        } else {
                            selection = nil
                        }
                    }
                    Toggle(isOn: binding) {
                        subview
                    }
                    .toggleStyle(.button)
                    .buttonStyle(.borderless)
                    .labelsHidden()
                    .labelStyle(.iconOnly)
                    .symbolVariant(tag == selection ? .fill : .none)
                }
            }
        }
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
