

address 0xa9876 {

	module amoeba_employee_score_matrix {
		// use Std::Signer;
		use 0xa9876::amoeba_map;
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;

		struct Ty_item_score has copy, drop, store { 
			completeness: u128,
			difficulty: u128,
			compliance: u128,
			item_score: u128,
		}

		struct Ty_human_key has copy, drop, store { 
			account_address: address,
			evaluation_event_time: u128,
		}
		
		struct Ty_human_score_entry has copy, drop, store { 
			selling_revenue: Ty_item_score,
			margin_profit: Ty_item_score,
			operation_profit: Ty_item_score,
			human_resource: Ty_item_score,
			investment_return: Ty_item_score,
		}

		struct Ty_human_score_table has key {
			rows: amoeba_map::T<Ty_human_key, Ty_human_score_entry>,
		}
		

		public fun module_account_addrss(): address 
		{
			@0xa9876
		}
		public fun genesis_addrss(): address
		{
			module_account_addrss()
		}
		
		fun make_item(): Ty_item_score
		{
			Ty_item_score {
				completeness: 0,
				difficulty: 0,
				compliance: 0,
				item_score: 0,
			}
		}
		
		fun make_human_score(): Ty_human_score_entry
		{
			Ty_human_score_entry {
				selling_revenue: make_item(),
				margin_profit: make_item(),
				operation_profit: make_item(),
				human_resource: make_item(),
				investment_return: make_item(),
			}
		}
		
		fun compute_raw_score(_user: address): u128
		{
			0
		}
		

		fun compute_avg_raw_score(): u128
		{
			0
		}

		fun compute_score(_user: address): u128
		{
			0
		}
		
	}

}

