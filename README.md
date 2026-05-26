# stygian-atproto

AT Protocol OAuth and DPoP utilities for Stygian gateway services.

## Modules

- **DPoPHtu** — RFC 9449 `htu` canonicalization (extracted from GatewayCore)
- **ForwardedHTTP** — reverse-proxy scheme inference
- **OAuthScopes** — scope string helpers (stub)

Depends on [stygian-core](../stygian-core) via local path.

## Development

```bash
scripts/bootstrap.sh
scripts/check.sh
```

## License

MIT — see [LICENSE](LICENSE).
