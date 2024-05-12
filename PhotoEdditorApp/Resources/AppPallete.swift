import UIKit

final class AppPallete {
    
    private init() {}
    
    static func getColor(named name: String) -> UIColor {
        if let color = UIColor(named: name) {
            return color
        }
        return UIColor()
    }
    
    static let mainBG = getColor(named: "mainBackground")
    static let titleTextColor = getColor(named: "titleTextColor")
    static let buttonBg = getColor(named: "buttonBackground1")
    static let filtersBG = getColor(named: "filtersBackground")
}
