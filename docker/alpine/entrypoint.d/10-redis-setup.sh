#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [redis] Setting up redis..."; fi

# Random REDIS_PASS Generator
if [ -z "${REDIS_PASS}" ]; then
  {
    REDIS_PASS=$(openssl rand -base64 33)
    echo "REDIS_PASS = ${REDIS_PASS}"
  }
fi

# set REDIS_PORT
if [ -n "${REDIS_PORT}" ]; then
  sed -i "s|^port 6379|port ${REDIS_PORT}|g" "${REDIS_CONFIG_PATH}"
fi

# set REDIS_PASS
# Check if the password environment variable is set
if [ -n "${REDIS_PASS}" ]; then
  # --------------------------------------------------------------------------
  # Step 1: Escape special characters
  # --------------------------------------------------------------------------
  # We use '|' as the sed delimiter, so we must escape it.
  # We also need to escape '\' (escape char) and '&' (sed match reference).
  # Logic:
  #   [\\|&] matches any backslash, pipe, or ampersand.
  #   \\&    replaces it with a literal backslash followed by the matched char.
  ESCAPED_PASS=$(printf '%s\n' "${REDIS_PASS}" | sed 's/[\\|&]/\\&/g')

  # --------------------------------------------------------------------------
  # Step 2: Update redis.conf safely
  # --------------------------------------------------------------------------
  # Regex Breakdown:
  #   ^               : Start of the line (Prevents matching inside comments)
  #   [[:space:]]*    : Optional leading whitespace (Indentation)
  #   #*              : Optional comment character (Handles commented out config)
  #   [[:space:]]*    : Optional whitespace after the hash
  #   requirepass     : The exact configuration key
  #   [[:space:]]\+   : At least ONE whitespace (Space or Tab)
  #   foobared        : The default placeholder value (Ensures Idempotency)
  #   [[:space:]]*    : Optional trailing whitespace
  #   $               : End of the line (Ensures strict matching)
  sed -i \
    "s|^[[:space:]]*#*[[:space:]]*requirepass[[:space:]]\+foobared[[:space:]]*$|requirepass ${ESCAPED_PASS}|" \
    "${REDIS_CONFIG_PATH}"
fi

# set DISALLOW_USER_LOGIN_REMOTELY
if [ "${DISALLOW_USER_LOGIN_REMOTELY}" -eq 1 ]; then
  sed -i "s|^bind.*|bind 127.0.0.1 ::1|g" "${REDIS_CONFIG_PATH}"
else
  sed -i "s|^bind.*|bind * -::*|g" "${REDIS_CONFIG_PATH}"
fi

if [ "$DEBUG" = "true" ]; then echo "→ [redis] Redis has been set up."; fi
