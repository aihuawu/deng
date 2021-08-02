

address 0xa9876 {

	module amoeba_basic_config {
		use Std::Signer;
		use 0xa9876::amoeba_map;
		use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;
		
		struct Ty_config_info_entry has copy, drop, store {
			base_interest_rate_p12: u128, // 12 decimals
		}
	
		struct Ty_config_info_table has key {
			rows: amoeba_map::T<u128, Ty_config_info_entry>,
			singleton_id: u128,
		}
		
		struct Ty_capablity_init has key {
			// genesis_addrss: address,
			config_capablity_created: bool,
		}
		
		struct Ty_config_capablity has key, store {
		}
		
		public fun module_account_addrss(): address 
		{
			@0xa9876
		}
		public fun genesis_addrss(): address
		{
			module_account_addrss()
		}
		public fun init(genesis_account: &signer)
		{
			let sender = Signer::address_of(genesis_account);
			assert(sender == genesis_addrss(), 42);
			assert(!exists<Ty_capablity_init>(sender), 42);
			
			move_to(genesis_account, Ty_capablity_init {
				// genesis_addrss: sender,
				config_capablity_created: false,
			});
		}
		public fun create_config_capablity(genesis_account: &signer): Ty_config_capablity
			acquires Ty_capablity_init
		{
			let sender = Signer::address_of(genesis_account);
			assert(sender == genesis_addrss(), 42);
			assert(exists<Ty_capablity_init>(genesis_addrss()), 42);
			

			let init = borrow_global_mut<Ty_capablity_init>(genesis_addrss());
			assert(init.config_capablity_created == false, 42);
			init.config_capablity_created = true;

			Ty_config_capablity {}
		}
		
		
		
		
		public fun create(genesis_account: &signer): u128
			acquires Ty_config_info_table
		{
			let sender = Signer::address_of(genesis_account);
			assert(sender == genesis_addrss(), 42);
			assert(!exists<Ty_config_info_table>(sender), 42);
			
			move_to(genesis_account, Ty_config_capablity {});
			
			let one_p12 = 1000*1000*1000*1000;
			let singleton_id = amoeba_next_id::next_id();
			let v = Ty_config_info_entry { base_interest_rate_p12: one_p12 * 2 / 100 };
			
			move_to(genesis_account, Ty_config_info_table { singleton_id, rows: amoeba_map::empty() });
			
			let tbl = borrow_global_mut<Ty_config_info_table>(sender);
			tbl.singleton_id = singleton_id;
			let rows = &mut tbl.rows;
			amoeba_map::insert(rows, singleton_id, v);
			singleton_id
		}
		
		public fun get_base_interest_rate_p12(): u128
			acquires Ty_config_info_table
		{
			let tbl = borrow_global<Ty_config_info_table>(genesis_addrss());
			let e = amoeba_map::get(&tbl.rows, &tbl.singleton_id);
			e.base_interest_rate_p12
		}
		
		public fun set_base_interest_rate_p12(_cap: &Ty_config_capablity, rate: u128)
			acquires Ty_config_info_table
		{
			let tbl = borrow_global_mut<Ty_config_info_table>(genesis_addrss());
			let e = amoeba_map::get_mut(&mut tbl.rows, &tbl.singleton_id);
			e.base_interest_rate_p12 = rate;
		}
		
	}

}

