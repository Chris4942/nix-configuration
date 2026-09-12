#!/usr/bin/env bash
# Use this script to generate a keyfile for zwave-js
set -euo pipefail

generate_key() {
  < /dev/urandom tr -dc A-F0-9 | head -c32 ;echo
}

jq -n \
  "{
    securityKeys: {
      S0_Legacy: \"$(generate_key)\",
      S2_Unauthenticated: \"$(generate_key)\",
      S2_Authenticated: \"$(generate_key)\",
      S2_AccessControl: \"$(generate_key)\"
    }
  }"
