import UIKit

// MARK: - PBFonts

final class AppFonts {
    
    private init() {}
    
    public static func getFont(ofsize: CGFloat, weight: UIFont.Weight) -> UIFont {
        return .systemFont(ofSize: ofsize, weight: weight)
    }
    
    static let bold30 = getFont(ofsize: 30, weight: .bold)
    
    /// User for Titles
    static let bold20 = getFont(ofsize: 20, weight: .bold)
    
    /// Use for semiTitles
    static let medium15 = getFont(ofsize: 15, weight: .medium)
    
    /// Use for normal expressions
    static let regular15 = getFont(ofsize: 15, weight: .regular)
    
    /// Use for textfields
    static let regular13 = getFont(ofsize: 13, weight: .regular)
}
