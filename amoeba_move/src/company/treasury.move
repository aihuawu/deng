

address 0xa9876 {

	module amoeba_company_treasury {
		use Std::Signer;
		use 0xa9876::amoeba_basic_super_user;
		// use 0xa9876::amoeba_map;
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;

		struct Ty_capablity_init has key {
		}
		
		
		struct Ty_treasury_capablity_store has key {
			item: amoeba_basic_super_user::Ty_treasury_capablity,
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
			});
		}
		
		
		public fun store_treasury_capablity(
			genesis_account: &signer, treasury_capablity: amoeba_basic_super_user::Ty_treasury_capablity)
		{
			let sender = Signer::address_of(genesis_account);
			assert(sender == genesis_addrss(), 42);
			assert(exists<Ty_capablity_init>(genesis_addrss()), 42);
			assert(!exists<Ty_treasury_capablity_store>(genesis_addrss()), 42);
			
			move_to(genesis_account, Ty_treasury_capablity_store {
				item: treasury_capablity,
			});
		}
	
		
		
		public fun set_base_interest_rate_p12(genesis_account: &signer, rate_p12: u128)
			acquires Ty_treasury_capablity_store
		{
			let sender = Signer::address_of(genesis_account);
			assert(sender == genesis_addrss(), 42);

			let cap = borrow_global<Ty_treasury_capablity_store>(genesis_addrss()); 
			amoeba_basic_super_user::set_base_interest_rate_p12(& cap.item, rate_p12);
		}
	}

}

