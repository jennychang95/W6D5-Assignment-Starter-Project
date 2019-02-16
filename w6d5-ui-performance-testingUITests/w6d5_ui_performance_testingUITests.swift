import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()

        app = XCUIApplication()
    }

    override func tearDown() {
    }
    
    
    func addMeal(mealName: String, numberOfCalories: Int) {
        
        app.navigationBars["Master"].buttons["Add"].tap()
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealName)
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText(String(numberOfCalories))
        
        addAMealAlert.buttons["Ok"].tap()
    }
    
    func deleteMeal(mealName: String, numberOfCalories: Int) {
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .table).element.tap()
        
        let staticText = app.tables.staticTexts["\(mealName) - \(numberOfCalories)"]
        if staticText.exists {
            staticText.swipeLeft()
            app.tables.buttons["Delete"].tap()
        } else {
            print("can't find ya")
        }
        
    }
    
    
    func showMealDetail(mealName: String, numberOfCalories: Int) {
        
        let staticText = app.tables.staticTexts["\(mealName) - \(numberOfCalories)"]
        if staticText.exists {
        staticText.tap()
        } else {
            print("doesn't exist")
        }
    }

    func test_AddMeal() {
        
        let meal = "Cucumber"
        let calories = 30
        
        addMeal(mealName: meal, numberOfCalories: calories)
        
        XCTAssert(app.tables.staticTexts["Cucumber - 30"].exists)
        
    }
/*
    func testDeleteFirstMeal() {

        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .table).element.tap()

        let firstCell = app.tables.cells.allElementsBoundByIndex.first
        firstCell?.swipeLeft()
        XCUIApplication().tables.buttons["Delete"].tap()

    }
 */
    
    func test_DeleteSpecificItem() {
        
        let meal = "mushroom"
        let calories = 200
        
        deleteMeal(mealName: meal, numberOfCalories: calories)
        sleep(3)
        XCTAssertFalse(app.tables.staticTexts["mushroom - 200"].exists)
        
    }
    
    func test_ShowDetail() {
        let meal = "pastry"
        let calories = 500
        
        showMealDetail(mealName: meal, numberOfCalories: calories)
        
        XCTAssertEqual(app.staticTexts["NotMuchDetailButWhatever"].label, "pastry - 500")

        app/*@START_MENU_TOKEN@*/.staticTexts["NotMuchDetailButWhatever"]/*[[".staticTexts[\"pastry - 500\"]",".staticTexts[\"NotMuchDetailButWhatever\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Detail"].buttons["Master"].tap()
        
    }

    func test_DeletesAllMeals() {
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .table).element.tap()
        
        
        for _ in 0..<app.tables.staticTexts.count {
            
            if app.tables.staticTexts.count == 0 {
                return
            }
            
            let cell = app.tables.cells.allElementsBoundByIndex.first
            cell?.swipeLeft()
            XCUIApplication().tables.buttons["Delete"].tap()
        }
        
        XCTAssertEqual(app.tables.staticTexts.count, 0)
        
    }
    
}
