

address 0xa9876 {
	
	
	
	module amoeba_nft_erc721 {
		use Std::Signer;
		use 0xa9876::amoeba_map;
		use 0xa9876::amoeba_next_id;
		
		struct Ty_token_key has copy, drop, store {
			issuer: address,
			type_id: u128,
		}

		struct Ty_token_owner_table has key {
			rows: amoeba_map::T<Ty_token_key, amoeba_map::T<u128, address>>,
		}
		
		public fun make_token_key(
			issuer: address, type_id: u128): Ty_token_key
		{
			Ty_token_key { issuer, type_id }
		}
		public fun token_key_issuer(token: &Ty_token_key): address
		{
			token.issuer
		}
		public fun token_key_type(token: &Ty_token_key): u128
		{
			token.type_id
		}
	
		public fun accept(user_account: &signer)
		{
			let sender = Signer::address_of(user_account);
			
			if (!exists<Ty_token_owner_table>(sender)) {
				move_to(user_account, Ty_token_owner_table { rows: amoeba_map::empty() })
			};
		}
	
		
		public fun create(issuer_account: &signer): Ty_token_key
			acquires Ty_token_owner_table
		{
			let sender = Signer::address_of(issuer_account);
			
			let token = Ty_token_key { issuer: sender, type_id: amoeba_next_id::next_id() };
			
			let rows = &mut borrow_global_mut<Ty_token_owner_table>(sender).rows;
			amoeba_map::insert(rows, *&token, amoeba_map::empty());
			token
		}

		public fun mint(issuer_account: &signer, token: &Ty_token_key, user: address): u128
			acquires Ty_token_owner_table
		{
			let sender = Signer::address_of(issuer_account);
			assert(sender == token.issuer, 42);
						
			// todo check user exists? howto? moveto? check diem balance?
			let rows = &mut borrow_global_mut<Ty_token_owner_table>(sender).rows;
			let odic = amoeba_map::get_mut(rows, token);
			
			let id = amoeba_next_id::next_id();
			amoeba_map::insert(odic, id, user);
			id
		}

		public fun ownerOf(token: &Ty_token_key, id: u128): address
			acquires Ty_token_owner_table
		{
			// todo check user exists? howto? moveto? check diem balance?
			let rows = &mut borrow_global_mut<Ty_token_owner_table>(token.issuer).rows;
			let odic = amoeba_map::get_mut(rows, token);
			
			let owner = amoeba_map::get(odic, &id);
			*owner
		}

		public fun transfer(from_account: &signer, token: &Ty_token_key, to: address, id: u128)
			acquires Ty_token_owner_table
		{
			let sender = Signer::address_of(from_account);

			let rows = &mut borrow_global_mut<Ty_token_owner_table>(token.issuer).rows;
			let odic = amoeba_map::get_mut(rows, token);
			
			let owner = amoeba_map::get_mut(odic, &id);
			assert(sender == *owner, 42);
			*owner = to;
		}

	}
	
	
}
