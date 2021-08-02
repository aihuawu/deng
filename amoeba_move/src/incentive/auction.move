

address 0xa9876 {

	module amoeba_incentive_auction {
		// use Std::Signer;
		use 0xa9876::amoeba_map;
		use 0xa9876::amoeba_ft_erc20;
		
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;

		struct Ty_auction_key has copy, drop, store {
			issuer: address,
			type_id: u128,
		}
		
		struct Ty_incentive_bond_auction_entry has copy, drop, store { 
			auction: Ty_auction_key,
			bond_token: amoeba_ft_erc20::Ty_token_key,
			curcency_token: amoeba_ft_erc20::Ty_token_key,
			min_price_p12: u128,
			max_price_p12: u128,
			start_time: u128,
			end_time: u128,
			execute_start_time: u128,
			execute_end_time: u128,
			// more .....
		}
		
		
		struct Ty_incentive_bond_auction_table has key { 
			rows: amoeba_map::T<Ty_auction_key, Ty_incentive_bond_auction_entry>,
		}
		

		public fun module_account_addrss(): address 
		{
			@0xa9876
		}
		public fun genesis_addrss(): address
		{
			module_account_addrss()
		}
		
		public fun create_bond_auction()
		{
		
		}
		
		public fun bid()
		{
		
		}
		public fun close()
		{
		
		}
		public fun post_close() // after close
		{
		
		}
	
	}

}

