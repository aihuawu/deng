

address 0xa9876 {

	module amoeba_basic_log {
		use Std::Signer;
		// use 0xa9876::amoeba_map;
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;
		
		
		
		struct Ty_capablity_init has key {
			// genesis_addrss: address,
			log_capablity_created: bool,
		}
		
		struct Ty_log_capablity has key, store {
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
				log_capablity_created: false,
			});
		}
		public fun create_log_capablity(genesis_account: &signer): Ty_log_capablity
			acquires Ty_capablity_init
		{
			let sender = Signer::address_of(genesis_account);
			assert(sender == genesis_addrss(), 42);
			assert(exists<Ty_capablity_init>(genesis_addrss()), 42);
			

			let init = borrow_global_mut<Ty_capablity_init>(genesis_addrss());
			assert(init.log_capablity_created == false, 42);
			init.log_capablity_created = true;

			Ty_log_capablity {}
		}
		
		
		
		
		
		public fun write_log(_cap: &Ty_log_capablity, _data: u128)
		{
			
		}
		public fun clear_log(_cap: &Ty_log_capablity)
		{
			
		}
		
	}

}

