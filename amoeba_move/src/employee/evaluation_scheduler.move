

address 0xa9876 {

	module amoeba_employee_evaluation_scheduler {
		// use Std::Signer;
		// use 0xa9876::amoeba_map;
		use 0xa9876::amoeba_timestamp;
		use 0xa9876::amoeba_employee_evaluation;
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;

		struct Ty_evaluation_next has copy, drop, store { 
			last_event_time: u128,
			interval: u128,
		}
		

		public fun module_account_addrss(): address 
		{
			@0xa9876
		}
		public fun genesis_addrss(): address
		{
			module_account_addrss()
		}
		public fun check_next(n: &mut Ty_evaluation_next)
		{
			let ts = amoeba_timestamp::current_time_ms();
			if(ts > n.last_event_time + n.interval){
				amoeba_employee_evaluation::create_item();
				n.last_event_time = ts;
			}
		}
	
	}

}

