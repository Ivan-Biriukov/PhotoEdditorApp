import UIKit

// MARK: - PBFonts

final class AppFonts {
    
    private init() {}
    
    public static func getFont(ofsize: CGFloat, weight: UIFont.Weight) -> UIFont {
        return .systemFont(ofSize: ofsize, weight: weight)
    }
        
    /// Use for semiTitles
    static let medium15 = getFont(ofsize: 15, weight: .medium)
}
