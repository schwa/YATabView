import SwiftUI
import YATabView

struct ContentView: View {

    @State
    var selection: Int = 1

    var body: some View {
        #if os(macOS)
        ContentUnavailableView("This space intentionally left blank.", image: "questionmark.circle")
        .inspector(isPresented: .constant(true)) {
            tabView
        }
        #else
        tabView
        #endif
    }

    var tabView: some View {
        YATabView(selection: $selection) {
            Form {
                Text("")
            }
            .tag(1)
            .yaTabItem { Label("Document", systemImage: "document") }

            Form {
                Text("2")
            }
            .tag(2)
            .yaTabItem { Label("Clock", systemImage: "clock") }

            Form {
                Text("3")
            }
            .tag(3)
            .yaTabItem { Label("Question", systemImage: "questionmark.circle") }

            Form {
                Text("4")
            }
            .tag(4)
            .yaTabItem { Label("Accessibility", systemImage: "accessibility") }

            Form {
                Text("5")
            }
            .tag(5)
            .yaTabItem { Label("Checklist", systemImage: "checklist") }
        }

    }
}

#Preview {
    ContentView()
}
