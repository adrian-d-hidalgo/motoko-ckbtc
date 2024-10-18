import Blob "mo:base/Blob";
import Buffer "mo:base/Buffer";
import Principal "mo:base/Principal";
import Nat8 "mo:base/Nat8";

module Utils {
	public func padPrincipalWithZeros(principal : Principal) : [Nat8] {
		var sub = Buffer.Buffer<Nat8>(32);
		let subaccount_blob = Principal.toBlob(principal);

		sub.add(Nat8.fromNat(subaccount_blob.size()));
		sub.append(Buffer.fromArray<Nat8>(Blob.toArray(subaccount_blob)));
		while (sub.size() < 32) {
			sub.add(0);
		};

		Buffer.toArray(sub);
	};
};
