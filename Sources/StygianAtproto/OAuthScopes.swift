import Foundation

/// OAuth scope helpers for ATProto clients (stub — expand as scopes are centralized).
public enum OAuthScopes {
  public static let atproto = "atproto"
  public static let repoWritePrefix = "repo:"

  public static func repoCollection(_ nsid: String, actions: [String] = ["create", "update", "delete"]) -> String {
    let joined = actions.joined(separator: ",")
    return "\(repoWritePrefix)\(nsid)?\(joined)"
  }

  public static func parseRepoCollection(from scope: String) -> String? {
    guard scope.hasPrefix(repoWritePrefix) else { return nil }
    let remainder = scope.dropFirst(repoWritePrefix.count)
    guard let question = remainder.firstIndex(of: "?") else {
      return String(remainder)
    }
    return String(remainder[..<question])
  }
}
