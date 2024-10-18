// Base Modules
import Principal "mo:base/Principal";

// Mops Modules
import CKBTC "mo:ckbtc-types";

import Utils "./utils";

shared actor class Backend(minter : Principal, ledger : Principal) = Self {
	stable let ckbtcMinter = actor (Principal.toText(minter)) : CKBTC.Minter.Service;
	stable let ckbtcLedger = actor (Principal.toText(ledger)) : CKBTC.Ledger.Service;

	private func getAccount(subaccount : Principal) : CKBTC.Ledger.Account {
		return {
			owner = Principal.fromActor(Self);
			subaccount = ?Utils.padPrincipalWithZeros(subaccount);
		};
	};

	public shared ({ caller }) func getDepositAddress() : async Text {
		let address = await ckbtcMinter.get_btc_address({
			owner = ?Principal.fromActor(Self);
			subaccount = ?Utils.padPrincipalWithZeros(caller);
		});

		return address;
	};

	public shared ({ caller }) func updateBalance() : async {
		#Ok : [CKBTC.Minter.UtxoStatus];
		#Err : CKBTC.Minter.UpdateBalanceError;
	} {
		await ckbtcMinter.update_balance({
			owner = ?Principal.fromActor(Self);
			subaccount = ?Utils.padPrincipalWithZeros(caller);
		});
	};

	public shared composite query ({ caller }) func getBalance() : async Nat {
		let balance = await ckbtcLedger.icrc1_balance_of(getAccount(caller));

		return balance;
	};

	public shared ({ caller }) func transfer(to : Principal, amount : Nat) : async CKBTC.Ledger.Result {
		let transfer = {
			from_subaccount = ?Utils.padPrincipalWithZeros(caller);
			to = getAccount(to);
			amount = amount;
			fee = null;
			memo = null;
			created_at_time = null;
		};

		await ckbtcLedger.icrc1_transfer(transfer);
	};
};
