#!/bin/sh
set -e

if [ -n "$INFISICAL_CLIENT_ID" ] && [ -n "$INFISICAL_CLIENT_SECRET" ]; then
    token=$(infisical login --method=universal-auth \
        --client-id="$INFISICAL_CLIENT_ID" \
        --client-secret="$INFISICAL_CLIENT_SECRET" \
        --silent --plain)
    unset INFISICAL_CLIENT_ID INFISICAL_CLIENT_SECRET
    exec infisical run --token="$token" \
        --projectId="$INFISICAL_PROJECT_ID" \
        --env="${INFISICAL_ENV:-prod}" \
        -- docker-php-entrypoint "$@"
fi

exec docker-php-entrypoint "$@"
