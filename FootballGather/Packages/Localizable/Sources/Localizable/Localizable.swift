import Foundation

protocol Localizable {
    static func localizedText(key: String, bundle: Bundle, comment: String) -> String
}

extension Localizable {
    static func localizedText(
        key: String,
        bundle: Bundle = .module,
        comment: String = ""
    ) -> String {
        NSLocalizedString(key, bundle: bundle, comment: comment)
    }
}
