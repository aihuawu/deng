

address 0xa9876 {

	module amoeba_basic_super_user {
		use Std::Signer;
		use 0xa9876::amoeba_basic_log;
		use 0xa9876::amoeba_basic_config;
		// use 0xa9876::amoeba_map;
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;
		
		struct Ty_capablity_init has key {
			// genesis_addrss: address,
			log_op_capablity_created: bool,
			treasury_capablity_created: bool,
		}
		
		struct Ty_log_op_capablity has key, store {
		}
		
		struct Ty_treasury_capablity has key, store {
		}
		
		struct Ty_log_capablity_store has key {
			item: amoeba_basic_log::Ty_log_capablity,
		}
		
		struct Ty_config_capablity_store has key {
			item: amoeba_basic_config::Ty_config_capablity,
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
				log_op_capablity_created: false,
				treasury_capablity_created: false,
			});
		}



		public fun create_treasury_capablity(genesis_account: &signer): Ty_treasury_capablity
			acquires Ty_capablity_init
		{
			let sender = Signer::address_of(genesis_account);
			assert(sender == genesis_addrss(), 42);
			assert(exists<Ty_capablity_init>(genesis_addrss()), 42);
			
			
			let init = borrow_global_mut<Ty_capablity_init>(genesis_addrss());
			assert(init.treasury_capablity_created == false, 42);
			init.treasury_capablity_created = true;
			
			Ty_treasury_capablity {}
		}
		
		public fun create_log_op_capablity(genesis_account: &signer): Ty_log_op_capablity
			acquires Ty_capablity_init
		{
			let sender = Signer::address_of(genesis_account);
			assert(sender == genesis_addrss(), 42);
			assert(exists<Ty_capablity_init>(genesis_addrss()), 42);
			
			
			let init = borrow_global_mut<Ty_capablity_init>(genesis_addrss());
			assert(init.log_op_capablity_created == false, 42);
			init.log_op_capablity_created = true;
			
			Ty_log_op_capablity {}
		}
		
		
		public fun store_log_capablity(
			genesis_account: &signer, log_capablity: amoeba_basic_log::Ty_log_capablity)
		{
			let sender = Signer::address_of(genesis_account);
			assert(sender == genesis_addrss(), 42);
			assert(exists<Ty_capablity_init>(genesis_addrss()), 42);
			assert(!exists<Ty_log_capablity_store>(genesis_addrss()), 42);
			
			move_to(genesis_account, Ty_log_capablity_store {
				item: log_capablity,
			});
		}
		
		
		public fun store_config_capablity(
			genesis_account: &signer, config_capablity: amoeba_basic_config::Ty_config_capablity)
		{
			let sender = Signer::address_of(genesis_account);
			assert(sender == genesis_addrss(), 42);
			assert(exists<Ty_capablity_init>(genesis_addrss()), 42);
			assert(!exists<Ty_config_capablity_store>(genesis_addrss()), 42);
			
			move_to(genesis_account, Ty_config_capablity_store {
				item: config_capablity,
			});
		}



		
		
		public fun write_log(_cap: &Ty_log_op_capablity, data: u128)
			acquires Ty_log_capablity_store
		{
			let cap = borrow_global<Ty_log_capablity_store>(genesis_addrss()); 
			amoeba_basic_log::write_log(& cap.item, data);
		}
		
		public fun set_base_interest_rate_p12(_cap: &Ty_treasury_capablity, rate_p12: u128)
			acquires Ty_config_capablity_store
		{
			let cap = borrow_global<Ty_config_capablity_store>(genesis_addrss()); 
			amoeba_basic_config::set_base_interest_rate_p12(& cap.item, rate_p12);
		}
	}

}

