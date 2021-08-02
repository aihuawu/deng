


address 0xa9876 {

	module amoeba_start_genesis {
		// use Std::Signer;
		use 0xa9876::amoeba_basic_log;
		use 0xa9876::amoeba_basic_config;
		use 0xa9876::amoeba_basic_super_user;
		use 0xa9876::amoeba_company_treasury;
		// use 0xa9876::amoeba_map;
		// use 0xa9876::amoeba_next_id;
		// use 0xa9876::amoeba_safe_math_util;
		

		// we need to bootstrap the system is steps.
		// we may run out of gas if we do it in one single step.
		// for solidity, there is maxium gas limit for deployment
		public fun start_0(genesis_account: &signer)
		{
			amoeba_basic_log::init(genesis_account);
			amoeba_basic_config::init(genesis_account);
			amoeba_basic_super_user::init(genesis_account);
			amoeba_company_treasury::init(genesis_account);
			// more ...
		}
		
		/** 
		We set up capability so that only authorized module can access the code
		*/
		public fun start_1(genesis_account: &signer)
		{
			let log_capablity = amoeba_basic_log::create_log_capablity(genesis_account);
			amoeba_basic_super_user::store_log_capablity(genesis_account, log_capablity);
			
			let config_capablity = amoeba_basic_config::create_config_capablity(genesis_account);
			amoeba_basic_super_user::store_config_capablity(genesis_account, config_capablity);
			
			let treasury_capablity = amoeba_basic_super_user::create_treasury_capablity(genesis_account);
			amoeba_company_treasury::store_treasury_capablity(genesis_account, treasury_capablity);

			// more ...
		}
		
		public fun start_2(_genesis_account: &signer)
		{
		
		}
		
		public fun start_3(_genesis_account: &signer)
		{
		
		}
	}

}

