#!/bin/bash

argument=$(cat <<CANDID
(variant {
    Init = record {
        btc_network = variant { Regtest };
        min_confirmations=opt 1;
        ledger_id = principal "$CKBTC_LEDGER_CANISTER_ID";
        kyt_principal = opt principal "$CKBTC_KYT_CANISTER_ID";
        ecdsa_key_name = "dfx_test_key";
        retrieve_btc_min_amount = 5_000;
        max_time_in_queue_nanos = 420_000_000_000;
        mode = variant {GeneralAvailability}
    }
})
CANDID
)

dfx deploy ckbtc-minter --argument "$argument"
