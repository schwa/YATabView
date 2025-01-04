# YATabView

Yet Another SwiftUI TabView and Picker replacement.

`YATabView` is inspired by the Xcode inspector style tab view. `YAPicker` came along for the ride.

![alt text](<Documentation/Screenshot 2025-01-03 at 23.18.12.png>)

## Installation

```sh
swift package add-dependency https://github.com/schwa/YATabView --branch main
swift package add-target-dependency YATabView <your-target-name>
```

## Usage

`YATabView` emulates `TabView`'s API. But all tabs need a `.tag()` modifier added _and_ the tab view must support a `selection` binding (selections can optionally be optional). This is a limitation of the current implementation and can be improved in the future. Instead of `.tabItem()` use `.yaTabItem()`.

```swift
#Preview {
    @Previewable @State
    var selection: Int = 1

    YATabView(selection: $selection) {
        Text("String-1")
        .tag(1)
        .yaTabItem { Image(systemName: "1.circle") }
        Text("String-2")
        .tag(2)
        .yaTabItem { Image(systemName: "2.circle") }
    }
}
```

`YATabView` is made uses a `YAPicker` to control the tab selection. `YAPicker` can be somewhat configured by implementing the `YAPickerCellStyle` and setting it with the `.yaPickerCellStyle()` modifier.
