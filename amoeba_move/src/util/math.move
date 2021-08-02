
address 0xa9876 {
	
	
	module amoeba_safe_math_util {
		
		public fun add(a: u128, b: u128): u128
		{
			a + b // todo check overflow?
		}
		
		public fun sub(a: u128, b: u128): u128
		{
			assert(a >= b, 42);
			a - b
		}
		
		public fun mul(a: u128, b: u128): u128
		{
			a * b
		}

		public fun div(a: u128, b: u128): u128
		{
			assert(b > 0, 42);
			a / b
		}
	
	}
}
