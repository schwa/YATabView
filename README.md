# YATabView

Yet Another SwiftUI TabView and Picker replacement.

`YATabView` is inspired by the Xcode inspector style tab view. `YAPicker` came along for the ride.

`YATabView` emulates `TabView`'s API. But currently all tabs need a `.tag()` modifier added _and_ the tab view must support a `selection` binding. This is a limitation of the current implementation and can be improved in the future.

![alt text](<Documentation/Screenshot 2025-01-03 at 23.18.12.png>)

## Installation

```sh
swift package add-dependency https://github.com/schwa/YATabView --branch main
swift package add-target-dependency YATabView <your-target-name>
```
