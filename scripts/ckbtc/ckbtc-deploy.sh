#!/bin/bash

# TODO: Set identity from params
dfx identity use default
export CKBTC_DEFAULT_PRINCIPAL=$(dfx identity get-principal)

# TODO: Set ic network from params
export CKBTC_LEDGER_CANISTER_ID=$(dfx canister id ckbtc-ledger)
export CKBTC_MINTER_CANISTER_ID=$(dfx canister id ckbtc-minter)
export CKBTC_KYT_CANISTER_ID=$(dfx canister id ckbtc-kyt)

SCRIPTS_DIR=$PWD/scripts
CKBTC_SCRIPTS_DIR=$SCRIPTS_DIR/ckbtc

sh $CKBTC_SCRIPTS_DIR/ckbtc-kyt.sh
sh $CKBTC_SCRIPTS_DIR/ckbtc-ledger.sh
sh $CKBTC_SCRIPTS_DIR/ckbtc-minter.sh
