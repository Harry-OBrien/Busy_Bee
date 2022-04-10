//import SwiftUI
//import Preferences
//
///**
//The main view of “Accounts” preference pane.
//*/
//struct AccountsView: View {
//	private let contentWidth: Double = 450.0
//    
//    let delegate: AccountSettingsDelegate
//    @State private var username: String = ""
//
//	var body: some View {
//		Preferences.Container(contentWidth: contentWidth) {
//			Preferences.Section(title: "User Name:") {
//				Toggle("Allow user to administer this computer", isOn: $isOn1)
//				Text("Administrator has root access to this machine.")
//					.preferenceDescription()
//				Toggle("Allow user to access every file", isOn: $isOn2)
//			}
//			Preferences.Section(title: "Show scroll bars:") {
//				Picker("", selection: $selection1) {
//					Text("When scrolling").tag(0)
//					Text("Always").tag(1)
//				}
//					.labelsHidden()
//					.pickerStyle(RadioGroupPickerStyle())
//			}
//			Preferences.Section(label: {
//				Toggle("Some toggle", isOn: $isOn3)
//			}) {
//				Picker("", selection: $selection2) {
//					Text("Automatic").tag(0)
//					Text("Manual").tag(1)
//				}
//					.labelsHidden()
//					.frame(width: 120.0)
//				Text("Automatic mode can slow things down.")
//					.preferenceDescription()
//			}
//			Preferences.Section(title: "Preview mode:") {
//				Picker("", selection: $selection3) {
//					Text("Automatic").tag(0)
//					Text("Manual").tag(1)
//				}
//					.labelsHidden()
//					.frame(width: 120.0)
//				Text("Automatic mode can slow things down.")
//					.preferenceDescription()
//			}
//		}
//	}
//}
//
//struct AccountsView_Previews: PreviewProvider {
//	static var previews: some View {
//		AccountsView()
//	}
//}
