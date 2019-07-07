//
// Created by choimake on 2019-07-06.
//


import XCTest
@testable import SearchWikipedia

class WikipediaPageTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCorrectDecode() {
        // SwiftでのjsonのresponseはData型
        // json文字列はcurlで適当に取得
        // 実行コマンド: curl -X GET "https://www.mediawiki.org/w/api.php?format=json&action=query&list=search&srsearch={任意の文字列}"
        let resJsonStr = "{\"batchcomplete\":\"\",\"query\":{\"searchinfo\":{\"totalhits\":1,\"suggestion\":\"require once\",\"suggestionsnippet\":\"<em>require once</em>\"},\"search\":[{\"ns\":0,\"title\":\"Extension requests/Resolved\",\"pageid\":30046,\"size\":48560,\"wordcount\":6829,\"snippet\":\"August 2006 (UTC) I copied the code and put it in a .php file and did the <span class=\\\"searchmatch\\\">requireonce</span> editing in the localsettings.php, but everytime I create a Person/ article\",\"timestamp\":\"2019-04-25T08:20:27Z\"}]}}"
        let correctResponse = resJsonStr.data(using: .utf8)!

        // decodeに成功するかどうか判定 -> 例外が投げられないかどうか
        XCTAssertNoThrow(try JSONDecoder().decode(WikipeidaSearchResponse.self, from: correctResponse))

        do {
            let decodedResponse = try JSONDecoder().decode(WikipeidaSearchResponse.self, from: correctResponse)

            let wikiPage = decodedResponse.query.search[0]

            // 各パラメータの同値判定
            XCTAssertEqual(wikiPage.id, "30046")
            XCTAssertEqual(wikiPage.title, "Extension requests/Resolved")
            XCTAssertEqual(wikiPage.url, "https://ja.wikipedia.org/w/index.php?curid=\(wikiPage.id)")
        } catch {
            // XCTAssertNoThrowのテストやってるから、ここでの判定はいらない
            // でも書き方がイケてない気がする
        }
    }

    func testIncorrectDecode() {
        let resJsonStr = "{\"error\":{\"code\":\"nosrsearch\",\"info\":\"The \\\"srsearch\\\" parameter must be set.\",\"*\":\"See https://www.mediawiki.org/w/api.php for API usage. Subscribe to the mediawiki-api-announce mailing list at &lt;https://lists.wikimedia.org/mailman/listinfo/mediawiki-api-announce&gt; for notice of API deprecations and breaking changes.\"},\"servedby\":\"mw1278\"}"
        let incorrectResponse = resJsonStr.data(using: .utf8)!

        // decodeに失敗するかどうか判定 -> 例外が投げるかどうが
        XCTAssertThrowsError(try JSONDecoder().decode(WikipeidaSearchResponse.self, from: incorrectResponse))

    }
}
