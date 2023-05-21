//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/05/21.
//

import SwiftUI

class DebugRootPresenter: ObservableObject {
    @Published var isPresentedLicenseList: Bool = false

    func showLicenseList() {
        isPresentedLicenseList = true
    }
}

struct DebugRootView: View {
    @StateObject var presenter = DebugRootPresenter()

    var body: some View {
        // TODO: NavigationStack対応
        NavigationView {
            List {
                Button(action: { presenter.showLicenseList() }) {
                    Text("ライセンス情報")
                }
                .sheet(isPresented: $presenter.isPresentedLicenseList) {
                    LicenseListView()
                }
            }
            .listStyle(.automatic)
            .navigationBarTitle("Debug")
        }
    }
}

struct DebugRootView_Previews: PreviewProvider {
    static var previews: some View {
        DebugRootView()
    }
}

class LicenseListPresenter: ObservableObject {
    @Published private(set) var licenseList: [LicensesPlugin.License] = LicensesPlugin.licenses
    @Published private(set) var selectedLicense: LicensesPlugin.License?
    @Published var showLicenseDetail: Bool = false

    init() {
        licenseList.append(.init(id: "カスタムライセンス", name: "カスタムライセンス", licenseText: "カスタムライセンスのライセンス"))
    }

    func setSelectedLicense(_ license: LicensesPlugin.License) {
        selectedLicense = license
        showLicenseDetail = true
    }
}

struct LicenseListView: View {
    @StateObject var presenter: LicenseListPresenter = .init()

    var body: some View {
        NavigationView {
            List {
                ForEach(presenter.licenseList) { license in
                    Button {
                        presenter.setSelectedLicense(license)
                    } label: {
                        Text(license.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .sheet(isPresented: $presenter.showLicenseDetail) { LicenseDetailView(license: presenter.selectedLicense ?? .init(id: "", name: "", licenseText: "")) }
            .navigationTitle("Licenses")
        }
    }
}

struct LicenseListView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseListView()
    }
}

struct LicenseDetailView: View {
    let license: LicensesPlugin.License

    var body: some View {
        NavigationView {
            Group {
                if let licenseText = license.licenseText {
                    ScrollView {
                        Text(licenseText)
                            .padding()
                    }
                } else {
                    Text("No License Found")
                }
            }
            .navigationTitle(license.name)
        }
    }
}

struct LicenseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseDetailView(license: .init(id: "testID", name: "testName", licenseText: nil))
    }
}
