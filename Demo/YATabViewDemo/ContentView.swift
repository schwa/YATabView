import SwiftUI
import YATabView

struct ContentView: View {
    @State
    private var selection: Int = 1

    var body: some View {
        #if os(macOS)

        ZStack {
            YAPicker(selection: $selection) {
                Label("Document", systemImage: "document").tag(1)
                Label("Clock", systemImage: "clock").tag(2)
                Label("Question", systemImage: "questionmark.circle").tag(3)
            }
            .padding()
        }

        .inspector(isPresented: .constant(true)) {
            tabView
                .inspectorColumnWidth(min: 50, ideal: 300, max: 400)
        }
        #else
        tabView
        #endif
    }

    var tabView: some View {
        YATabView(selection: $selection) {
            MeshGradient(width: 2, height: 2, points: [
                [0, 0], [1, 0], [0, 1], [1, 1]
            ], colors: [.red, .green, .blue, .yellow])
            .tag(1)
            .yaTabItem { Label("Document", systemImage: "document") }

            MeshGradient(width: 2, height: 2, points: [
                [0, 0], [1, 0], [0, 1], [1, 1]
            ], colors: [.purple, .orange, .pink, .brown])
            .tag(2)
            .yaTabItem { Label("Clock", systemImage: "clock") }

            MeshGradient(width: 2, height: 2, points: [
                [0, 0], [1, 0], [0, 1], [1, 1]
            ], colors: [.yellow, .green, .blue, .red])
            .tag(3)
            .yaTabItem { Label("Question", systemImage: "questionmark.circle") }

            MeshGradient(width: 2, height: 2, points: [
                [0, 0], [1, 0], [0, 1], [1, 1]
            ], colors: [.black, .pink, .white, .green])
            .tag(4)
            .yaTabItem { Label("Accessibility", systemImage: "accessibility") }

            MeshGradient(width: 2, height: 2, points: [
                [0, 0], [1, 0], [0, 1], [1, 1]
            ], colors: [.pink, .orange, .yellow, .green])
            .tag(5)
            .yaTabItem { Label("Checklist", systemImage: "checklist") }
        }
    }
}

#Preview {
    ContentView()
}
