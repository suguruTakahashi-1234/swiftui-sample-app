//
//  SettingView.swift
//
//
//  Created by Suguru Takahashi on 2023/04/26.
//

import SwiftUI

protocol ForEachAllCasesUsable: CaseIterable, Identifiable, RawRepresentable {}

extension ForEachAllCasesUsable {
    public var id: RawValue { rawValue }
}

enum TransitionMethod {
    case push, modal
}

protocol Navigatable: ForEachAllCasesUsable {
    associatedtype DestinationView: View
    var name: String { get }
    var transitionMethod: TransitionMethod { get }
    var destinationView: DestinationView { get }
}

enum Fruit: String, Navigatable {
    case apple = "Apple"
    case banana = "Banana"
    case cherry = "Cherry"

    var name: String {
        rawValue
    }

    var transitionMethod: TransitionMethod {
        switch self {
        case .apple:
            return .push
        case .banana, .cherry:
            return .modal
        }
    }

    @ViewBuilder
    var destinationView: some View {
        switch self {
        case .apple:
            AppleView()
        case .banana:
            BananaView()
        case .cherry:
            CherryView()
        }
    }
}

enum Vegetable: String, Navigatable {
    case carrot = "Carrot"
    case tomato = "Tomato"
    case pepper = "Pepper"

    var name: String {
        rawValue
    }

    var transitionMethod: TransitionMethod {
        switch self {
        case .carrot, .pepper:
            return .push
        case .tomato:
            return .modal
        }
    }

    @ViewBuilder
    var destinationView: some View {
        DetailView(item: rawValue)
    }
}

class SettingViewModel: ObservableObject {
    @Published var showFruitModal: Fruit?
    @Published var showVegetableModal: Vegetable?

    func showModal(_ item: some Navigatable) {
        switch item {
        case let fruitItem as Fruit:
            showFruitModal = fruitItem
        case let vegetableItem as Vegetable:
            showVegetableModal = vegetableItem
        default:
            fatalError("Unexpected item type: \(type(of: item))")
        }
    }
}

struct SettingView: View {
    @StateObject var viewModel = SettingViewModel()

    var body: some View {
        // TODO: NavigationStack対応
        NavigationView {
            List {
                sectionForItems("Fruits", items: Fruit.allCases, color: .blue)
                sectionForItems("Vegetables", items: Vegetable.allCases, color: .red)
            }
            .listStyle(.automatic)
            .navigationBarTitle("Food List")
            .sheet(item: $viewModel.showFruitModal) { $0.destinationView }
            .sheet(item: $viewModel.showVegetableModal) { $0.destinationView }
        }
    }

    private func sectionForItems(_ header: String, items: [some Navigatable], color: Color) -> some View {
        Section(header: Text(header)) {
            ForEach(items) { item in
                switch item.transitionMethod {
                case .push:
                    NavigationLink(destination: item.destinationView) {
                        Text(item.name)
                    }
                case .modal:
                    Button(action: {
                        viewModel.showModal(item)
                    }) {
                        Text(item.name)
                    }
                }
            }
            .listRowSeparatorTint(color)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct DetailView: View {
    let item: String

    var body: some View {
        Text("You selected \(item)")
            .navigationBarTitle(item)
    }
}

struct AppleView: View {
    var body: some View {
        Text("This is Apple View")
            .navigationBarTitle("Apple")
    }
}

struct BananaView: View {
    var body: some View {
        Text("This is Banana View")
            .navigationBarTitle("Banana")
    }
}

struct CherryView: View {
    var body: some View {
        Text("This is Cherry View")
            .navigationBarTitle("Cherry")
    }
}
