#!/bin/bash
export CKBTC_MINTER_CANISTER_ID=$(dfx canister id ckbtc-minter)
export CKBTC_LEDGER_CANISTER_ID=$(dfx canister id ckbtc-ledger)

dfx deploy backend --argument="(principal \"${CKBTC_MINTER_CANISTER_ID}\", principal \"${CKBTC_LEDGER_CANISTER_ID}\")"

