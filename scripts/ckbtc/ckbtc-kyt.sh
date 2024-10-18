#!/bin/bash

argument=$(cat <<CANDID
(variant {
    InitArg = record {
      minter_id = principal "$CKBTC_MINTER_CANISTER_ID";
      maintainers = vec {
        principal "$(dfx identity get-principal)"
      };
      mode = variant { AcceptAll }
    }
  })
CANDID
)

dfx deploy ckbtc-kyt --argument "$argument"

dfx canister call ckbtc-kyt set_api_key '(record { api_key = "" })'
