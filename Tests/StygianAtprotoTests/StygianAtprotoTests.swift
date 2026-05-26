@testable import StygianAtproto
import HTTPTypes
import Hummingbird
import NIOCore
import Testing

@Suite("DPoPHtu")
struct DPoPHtuTests {
  @Test("canonical prefers X-Forwarded-Proto over internal http scheme")
  func forwardedProtoWinsOverInternalScheme() {
    var headerFields = HTTPFields()
    headerFields[HTTPField.Name("X-Forwarded-Proto")!] = "https"
    let request = Request(
      head: .init(
        method: .get,
        scheme: "http",
        authority: "api.example.test",
        path: "/v1/publications/sidebar",
        headerFields: headerFields
      ),
      body: .init(buffer: ByteBuffer())
    )

    let canonical = DPoPHtu.canonical(for: request)
    #expect(canonical == "https://api.example.test/v1/publications/sidebar")
  }

  @Test("canonical omits query string per RFC 9449 htu")
  func omitsQueryString() {
    var headerFields = HTTPFields()
    headerFields[HTTPField.Name("X-Forwarded-Proto")!] = "https"
    let request = Request(
      head: .init(
        method: .get,
        scheme: "http",
        authority: "api.example.test",
        path: "/v1/appview/unread-counts?publicationIds=at%3A%2F%2Fdid%3Aplc%3Aexample",
        headerFields: headerFields
      ),
      body: .init(buffer: ByteBuffer())
    )

    let canonical = DPoPHtu.canonical(for: request)
    #expect(canonical == "https://api.example.test/v1/appview/unread-counts")
  }

  @Test("matches accepts path-only proof HTU when request has query params")
  func matchesPathOnlyProofAgainstQueryRequest() {
    let proof = "https://api.example.test/v1/appview/unread-counts"
    let expected = "https://api.example.test/v1/appview/unread-counts"
    #expect(DPoPHtu.matches(proofURL: proof, expected: expected))
  }
}

@Suite("OAuthScopes")
struct OAuthScopesTests {
  @Test("builds repo collection scope")
  func buildsRepoCollectionScope() {
    let scope = OAuthScopes.repoCollection("com.example.collection")
    #expect(scope == "repo:com.example.collection?create,update,delete")
    #expect(OAuthScopes.parseRepoCollection(from: scope) == "com.example.collection")
  }
}
