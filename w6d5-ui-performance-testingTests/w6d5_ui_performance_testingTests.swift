import XCTest
@testable import w6d5_ui_performance_testing

class w6d5_ui_performance_testingTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }


    func testPerformanceExample() {
        self.measure {
            PerformanceDataModel.doSomething()
        }
    }

}
