import SwiftUI

private struct PreferenceKeyBugTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct PreferenceKeyBug: View {
    @State private var title: String = ""
    @State private var page = false

    var body: some View {
        VStack(alignment: .center) {
            if !page {
                Text(verbatim: "Welcome screen")
                    .preference(key: PreferenceKeyBugTitlePreferenceKey.self, value: "Welcome screen")
            } else {
                Text(verbatim: "Current screen")
                    .preference(key: PreferenceKeyBugTitlePreferenceKey.self, value: "Current weight")
            }

            Spacer()

            Button(action: { page.toggle() }) {
                Text(verbatim: "Toggle")
            }

            Spacer()

            VStack {
                // If you comment this IF out,
                // onPreferenceChange magically starts to work
                if true {
                    Text(verbatim: "Title set by preference key:")
                }
                Text(title)
            }
        }
            .onPreferenceChange(PreferenceKeyBugTitlePreferenceKey.self) { newTitle in
                title = newTitle
            }
    }
}
