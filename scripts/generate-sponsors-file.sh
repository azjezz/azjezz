#!/bin/bash
set -e

if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI ('gh') is not installed. Please install it to continue."
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "Error: 'jq' is not installed. Please install it to continue."
    exit 1
fi

GRAPHQL_QUERY='
query($cursor: String) {
  viewer {
    sponsorshipsAsMaintainer(first: 100, after: $cursor, includePrivate: true) {
      pageInfo {
        hasNextPage
        endCursor
      }
      nodes {
        isActive
        sponsorEntity {
          ... on User {
            login
            name
            avatarUrl
            websiteUrl
          }
          ... on Organization {
            login
            name
            avatarUrl
            websiteUrl
          }
        }
        tier {
          monthlyPriceInDollars
          isCustomAmount
          isOneTime
        }
      }
    }
  }
}
'

gh api --paginate graphql -f query="$GRAPHQL_QUERY" | \
jq -s '
  map(.data.viewer.sponsorshipsAsMaintainer.nodes) | flatten
  | map(select(.isActive == true))
  | map({
    login: .sponsorEntity.login,
    name: .sponsorEntity.name,
    avatarUrl: .sponsorEntity.avatarUrl,
    websiteUrl: .sponsorEntity.websiteUrl,
    monthlyPriceInDollars: .tier.monthlyPriceInDollars,
    isCustomAmount: .tier.isCustomAmount,
    isOneTime: .tier.isOneTime
  })
  | sort_by(.monthlyPriceInDollars // 0)
  | reverse
  | group_by(.monthlyPriceInDollars)
  | map({key: (.[0].monthlyPriceInDollars | tostring), value: .})
  | from_entries
' \
> "$(dirname "$0")/../sponsors.json"
