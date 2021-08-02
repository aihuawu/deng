

address 0xa9876 {
	
	
	module amoeba_ft_erc20 {
		use Std::Signer;
		use 0xa9876::amoeba_map;
		use 0xa9876::amoeba_next_id;
		use 0xa9876::amoeba_safe_math_util;
		
		struct Ty_token_key has copy, drop, store {
			issuer: address,
			type_id: u128,
		}
		struct Ty_token_balance_table has key {
			rows: amoeba_map::T<Ty_token_key, u128>,
		}
		
		struct Ty_token_approve_table has key {
			rows: amoeba_map::T<Ty_token_key, amoeba_map::T<address, u128>>,
		}
		
		struct Ty_token_info_entry has copy, drop, store {
			symbol: vector<u8>, // string
			decimals: u8, // default = 9
			total: u128,
		}
		
		struct Ty_token_info_table has key {
			rows: amoeba_map::T<Ty_token_key, Ty_token_info_entry>,
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
			
			if (!exists<Ty_token_balance_table>(sender)) {
				move_to(user_account, Ty_token_balance_table { rows: amoeba_map::empty() });
			};
			if (!exists<Ty_token_info_table>(sender)) {
				move_to(user_account, Ty_token_info_table { rows: amoeba_map::empty() });
			};
			if (!exists<Ty_token_approve_table>(sender)) {
				move_to(user_account, Ty_token_approve_table { rows: amoeba_map::empty() });
			};
		}
	
		
		public fun create(issuer_account: &signer, symbol: vector<u8>): Ty_token_key
			acquires Ty_token_info_table
		{
			let sender = Signer::address_of(issuer_account);
			
			let token = Ty_token_key { issuer: sender, type_id: amoeba_next_id::next_id() };
			let v = Ty_token_info_entry { symbol: symbol, decimals: 9, total: 0 };
			
			let rows = &mut borrow_global_mut<Ty_token_info_table>(sender).rows;
			amoeba_map::insert(rows, *&token, v);
			token
		}
		
		public fun mint(issuer_account: &signer, token: &Ty_token_key, to: address, amount: u128)
			acquires Ty_token_info_table, Ty_token_balance_table
		{
			let sender = Signer::address_of(issuer_account);
			assert(sender == token.issuer, 42);
			
			let idic = &mut borrow_global_mut<Ty_token_info_table>(sender).rows;
			let info = amoeba_map::get_mut(idic, token);
			info.total = amoeba_safe_math_util::add(info.total, amount);
			
			let to_dic = &mut borrow_global_mut<Ty_token_balance_table>(to).rows;
			let to_bal = amoeba_map::get_mut(to_dic, token);
			*to_bal = amoeba_safe_math_util::add(*to_bal, amount);
		}

		public fun burn(issuer_account: &signer, token: &Ty_token_key, to: address, amount: u128)
			acquires Ty_token_info_table, Ty_token_balance_table
		{
			let sender = Signer::address_of(issuer_account);
			assert(sender == token.issuer, 42);
			
			let idic = &mut borrow_global_mut<Ty_token_info_table>(sender).rows;
			let info = amoeba_map::get_mut(idic, token);
			info.total = amoeba_safe_math_util::sub(info.total, amount);
			
			let to_dic = &mut borrow_global_mut<Ty_token_balance_table>(to).rows;
			let to_bal = amoeba_map::get_mut(to_dic, token);
			*to_bal = amoeba_safe_math_util::sub(*to_bal, amount);
		}
		
		public fun totalSupply(token: &Ty_token_key): u128
			acquires Ty_token_info_table
		{
			let idic = &mut borrow_global_mut<Ty_token_info_table>(token.issuer).rows;
			let info = amoeba_map::get_mut(idic, token);
			info.total
		}
		
		/**
		amount should be a coin type, but we simplify it.
		later, we will use diem std coin. 
		then it is possible to have error check at compile time, it is safer.
		*/
		public fun transfer(from_account: &signer, token: &Ty_token_key, to: address, amount: u128)
			acquires Ty_token_balance_table
		{
			let sender = Signer::address_of(from_account);
			
			let from_dic = &mut borrow_global_mut<Ty_token_balance_table>(sender).rows;
			let from_bal = amoeba_map::get_mut(from_dic, token);
			*from_bal = amoeba_safe_math_util::sub(*from_bal, amount);
			
			let to_dic = &mut borrow_global_mut<Ty_token_balance_table>(to).rows;
			let to_bal = amoeba_map::get_mut(to_dic, token);
			*to_bal = amoeba_safe_math_util::add(*to_bal, amount);
		}
		
		public fun balanceOf(token: &Ty_token_key, to: address): u128
			acquires Ty_token_balance_table
		{
			let to_dic = &mut borrow_global_mut<Ty_token_balance_table>(to).rows;
			*amoeba_map::get(to_dic, token)
		}

		public fun approve(user_account: &signer, token: &Ty_token_key, 
			to: address, amount: u128)
			acquires Ty_token_approve_table
		{
			let sender = Signer::address_of(user_account);
			
			let approve_dic = &mut borrow_global_mut<Ty_token_approve_table>(sender).rows;
			if (!amoeba_map::contains_key(approve_dic, token)) {
				amoeba_map::insert(approve_dic, *token, amoeba_map::empty());
			};
			let approve_to = amoeba_map::get_mut(approve_dic, token);
			if (!amoeba_map::contains_key(approve_to, &to)) {
				amoeba_map::insert(approve_to, to, 0);
			};
			let approve_bal = amoeba_map::get_mut(approve_to, &to);
			*approve_bal = amount;
		}
		
		public fun transferFrom(user_account: &signer, token: &Ty_token_key, 
			from: address, to: address, amount: u128)
			acquires Ty_token_balance_table, Ty_token_approve_table
		{
			let sender = Signer::address_of(user_account);
			
			// todo check amount > 0 or == 0, 
			// todo check user_account, from, same or not

			let approve_dic = &mut borrow_global_mut<Ty_token_approve_table>(from).rows;
			let approve_to = amoeba_map::get_mut(approve_dic, token);
			let approve_bal = amoeba_map::get_mut(approve_to, &sender);
			*approve_bal = amoeba_safe_math_util::sub(*approve_bal, amount);
			
			let from_dic = &mut borrow_global_mut<Ty_token_balance_table>(from).rows;
			let from_bal = amoeba_map::get_mut(from_dic, token);
			*from_bal = amoeba_safe_math_util::sub(*from_bal, amount);
			
			let to_dic = &mut borrow_global_mut<Ty_token_balance_table>(to).rows;
			let to_bal = amoeba_map::get_mut(to_dic, token);
			*to_bal = amoeba_safe_math_util::add(*to_bal, amount);
		}
		
	}
	
}
