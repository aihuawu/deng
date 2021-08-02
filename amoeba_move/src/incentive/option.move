

address 0xa9876 {

	module amoeba_incentive_option {
		// use Std::Signer;
		use 0xa9876::amoeba_map;
		use 0xa9876::amoeba_ft_erc20;
		
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;
		
		
		struct Ty_incentive_option_entry has copy, drop, store { 
			// option_token: amoeba_ft_erc20::Ty_token_key,
			target_token: amoeba_ft_erc20::Ty_token_key,
			curcency_token: amoeba_ft_erc20::Ty_token_key,
			purchase_price_p12: u128,
			execute_price_p12: u128,
			purchase_start_time: u128,
			purchase_end_time: u128,
			execute_start_time: u128,
			execute_end_time: u128,
			// more .....
		}
		
		
		struct Ty_incentive_option_table has key { 
			rows: amoeba_map::T<amoeba_ft_erc20::Ty_token_key, Ty_incentive_option_entry>,
		}
		

		public fun module_account_addrss(): address 
		{
			@0xa9876
		}
		public fun genesis_addrss(): address
		{
			module_account_addrss()
		}
		
		public fun create_option()
		{
		
		}
		
		public fun purchase_option()
		{
		
		}
		public fun execute_option()
		{
		
		}
	
	}

}

