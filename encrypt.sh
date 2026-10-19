#!/usr/bin/env bash
# Re-encrypt checkpoint_codes.yaml after editing it. Run this before committing.
#
#   GPG_PASSPHRASE=... ./encrypt.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
if [[ -z "${GPG_PASSPHRASE:-}" ]]; then
  echo "Set GPG_PASSPHRASE in the environment." >&2
  exit 1
fi
[[ -f "$ROOT/checkpoint_codes.yaml" ]] || { echo "no plaintext checkpoint_codes.yaml to encrypt" >&2; exit 1; }
gpg --batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" \
  --symmetric --cipher-algo AES256 -o "$ROOT/checkpoint_codes.yaml.gpg" "$ROOT/checkpoint_codes.yaml"
echo "encrypted checkpoint_codes.yaml -> checkpoint_codes.yaml.gpg"
