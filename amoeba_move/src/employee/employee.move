

address 0xa9876 {

	module amoeba_employee_employee {
		// use Std::Signer;
		use 0xa9876::amoeba_map;
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;
		
		struct Ty_employee_key has copy, drop, store { 
			employee_address: address,
			employee_event_time: u128,
		}
		
		struct Ty_employee_entry has copy, drop, store { 
			employee_status: u128, // start, finished
			total_score: u128,
			bonus_amount: u128,
			// more .....
		}
		
		
		struct Ty_employee_table has key { 
			rows: amoeba_map::T<Ty_employee_key, Ty_employee_entry>,
			last_key: Ty_employee_key,
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

