

address 0xa9876 {
	
	module amoeba_sbu_accounting {
		// use Std::Signer;
		use 0xa9876::amoeba_map;
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;
		
		struct Ty_accounting_key has copy, drop, store { 
			accounting_address: address,
			accounting_event_time: u128,
		}
		
		struct Ty_accounting_sumary_entry has copy, drop, store { 
			accounting_status: u128, // start, finished
			total_score: u128,
			bonus_amount: u128,
			// more .....
		}
		
		
		struct Ty_accounting_sumary_table has key { 
			rows: amoeba_map::T<Ty_accounting_key, Ty_accounting_sumary_entry>,
			last_key: Ty_accounting_key,
		}
		

		public fun module_account_addrss(): address 
		{
			@0xa9876
		}
		public fun genesis_addrss(): address
		{
			module_account_addrss()
		}
		public fun create_item()
		{
		
		}
	
	}

}

