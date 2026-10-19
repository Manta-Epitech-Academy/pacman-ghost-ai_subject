#!/usr/bin/env bash
# Decrypt checkpoint_codes.yaml.gpg so the subject can be synced from the
# command line. The admin Sync page does not need this: it asks for the
# passphrase and decrypts in the browser.
#
#   GPG_PASSPHRASE=... ./decrypt.sh
#
# The plaintext is gitignored: it must never be committed to a public repo.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
if [[ -z "${GPG_PASSPHRASE:-}" ]]; then
  echo "Set GPG_PASSPHRASE in the environment." >&2
  exit 1
fi
gpg --batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" \
  -o "$ROOT/checkpoint_codes.yaml" --decrypt "$ROOT/checkpoint_codes.yaml.gpg"
echo "decrypted checkpoint_codes.yaml.gpg -> checkpoint_codes.yaml"
