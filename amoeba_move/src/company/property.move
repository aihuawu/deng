

address 0xa9876 {

	module amoeba_company_property {
		// use Std::Signer;
		use 0xa9876::amoeba_map;
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;
		

		struct Ty_company_property_entry has copy, drop, store {
			name: vector<u8>, 
			url: vector<u8>, 
			nft_id: u128,
			estimated_value_p9: u128, // 9 decimals
		}
	
		struct Ty_company_property_table has key {
			rows: amoeba_map::T<u128, Ty_company_property_entry>,
			singleton_id: u128,
		}
		

		public fun module_account_addrss(): address 
		{
			@0xa9876
		}
		public fun genesis_addrss(): address
		{
			module_account_addrss()
		}
		
	}

}

