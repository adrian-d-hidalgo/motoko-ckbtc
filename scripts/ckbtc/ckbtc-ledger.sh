#!/bin/bash

TRANSFER_FEE=0
PRE_MINTED_TOKENS=10_000_000_000

argument=$(cat <<CANDID
(variant {
    Init = record {
        minting_account = record {
            owner = principal "$CKBTC_MINTER_CANISTER_ID"
        };
        transfer_fee = $TRANSFER_FEE : nat64;
        token_symbol = "ckBTC";
        token_name = "ckBTC";
        metadata = vec {};
        initial_balances = vec {
            record {
                record {
                    owner = principal "${CKBTC_LEDGER_CANISTER_ID}";
                }; 
                ${PRE_MINTED_TOKENS};
            };
        };
        archive_options = record {
            num_blocks_to_archive = 0 : nat64;
            trigger_threshold = 0 : nat64;
            controller_id = principal "aaaaa-aa"
        }
    }
})
CANDID
)

dfx deploy ckbtc-ledger --argument "$argument"
