


address 0xa9876 {
	
	
	
	// this module is not necessary for move, but in solidity, usually useful
	// we use the same pattern as solidity
	module amoeba_token_factory {
		use 0xa9876::amoeba_nft_erc721;
		use 0xa9876::amoeba_ft_erc20;
		
		public fun make_nft_erc721(issuer_account: &signer): 
			amoeba_nft_erc721::Ty_token_key
		{
			amoeba_nft_erc721::create(issuer_account)
		}
		
		public fun make_ft_erc20(issuer_account: &signer, symbol: vector<u8>): 
			amoeba_ft_erc20::Ty_token_key
		{
			amoeba_ft_erc20::create(issuer_account, symbol)
		}
	
	}
	
}
