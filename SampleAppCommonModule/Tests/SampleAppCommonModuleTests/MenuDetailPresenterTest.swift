//
//  MenuDetailPresenterTest.swift
//
//
//  Created by Suguru Takahashi on 2023/04/28.
//

import Nimble
import Quick
@testable import SampleAppCoreFoundation
@testable import SampleAppDomain
@testable import SampleAppPresentation

class MenuDetailPresenterTest: QuickSpec {
    override func spec() {
        describe("メニュー詳細画面") {
            var menu: Menu!
            var repository: MenuDetailRepositoryProtocolMock!
            var presenter: MenuDetailPresenter<MenuDetailRepositoryProtocolMock>!

            beforeEach {
                menu = .stub()
                repository = .init()
                presenter = .init(menu: menu, repository: repository)
            }

            describe("メニュー詳細画面のローディング") {
                context("ローディング前の場合") {
                    it("メニュー詳細が取得されていないこと（初期値の確認）") {
                        expect(repository.fetchCallCount).to(equal(0))
                        expect(presenter.menuDetail).to(equal(""))
                        expect(presenter.isShowingAlert).to(equal(false))
                    }
                }
                context("メニュー詳細の取得に成功した場合") {
                    beforeEach {
                        repository.fetchHandler = { menu in menu.name }
                        await presenter.onAppear()
                    }
                    it("メニューの詳細が表示されること") {
                        expect(repository.fetchCallCount).to(equal(1))
                        expect(presenter.menuDetail).to(equal(menu.name))
                    }
                }
                context("メニュー詳細の取得に失敗した場合") {
                    beforeEach {
                        repository.fetchHandler = { _ in throw MockError() }
                        presenter = .init(menu: menu, repository: repository)
                        await presenter.onAppear()
                    }
                    it("アラートとエラー文言が表示されること") {
                        expect(presenter.isShowingAlert).to(equal(true))
                        expect(presenter.errorMessage).to(equal("MockError"))
                    }
                }
            }
        }
    }
}
