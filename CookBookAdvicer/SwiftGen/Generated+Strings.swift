// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Good Buy!
  internal static let goodBuy = L10n.tr("Localizable", "goodBuy", fallback: "Good Buy!")
  /// ingredients
  internal static let ingredientTitle = L10n.tr("Localizable", "ingredientTitle", fallback: "ingredients")
  /// Nutrition Facts
  internal static let nutrition = L10n.tr("Localizable", "nutrition", fallback: "Nutrition Facts")
  /// CPFC amount per 100g: 
  internal static let nutritionDetails = L10n.tr("Localizable", "nutritionDetails", fallback: "CPFC amount per 100g: ")
  /// Choose category
  internal static let title = L10n.tr("Localizable", "title", fallback: "Choose category")
  /// List of dishes by category
  internal static let welcomeTitle = L10n.tr("Localizable", "welcomeTitle", fallback: "List of dishes by category")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type