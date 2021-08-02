

address 0xa9876 {
	

	module amoeba_next_id {
		use Std::Signer;
		
		struct T has key {
			id: u128,
		}
		
		public fun create(amoeba_account: &signer)
		{
			let sender = Signer::address_of(amoeba_account);
			let amoeba_addr = @0xa9876;
			assert(sender == amoeba_addr, 42);
			move_to(amoeba_account, T { id: 1000 });
		}
	
		public fun next_id(): u128
			acquires T
		{
			
			let amoeba_addr = @0xa9876;
			let n = borrow_global_mut<T>(amoeba_addr); 
			let id = n.id;
			n.id = n.id + 1;
			id
		}
	}

	module amoeba_timestamp {
		
		// milliseconds after 1970.01.01
		public fun current_time_ms(): u128
		{
			0
		}
	}
}
