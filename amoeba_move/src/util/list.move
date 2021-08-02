


address 0xa9876 {
	
	
	module amoeba_vector {
		use Std::Vector;
		
		struct T<E>  has copy, drop, store {
			ls: vector<E>,
		}
		
		public fun empty<E>(): T<E> {
			T { ls: Vector::empty() }
		}
		
		public fun length<E>(v: &T<E>): u64 {
			Vector::length(&v.ls)
		}
	
	
		public fun borrow<E>(v: &T<E>, i: u64): &E {
			Vector::borrow(&v.ls, i)
		}
	
		public fun push_back<E>(v: &mut T<E>, e: E) {
			Vector::push_back(&mut v.ls, e);
		}
	
	
		public fun borrow_mut<E>(v: &mut T<E>, i: u64): &mut E {
			Vector::borrow_mut(&mut v.ls, i)
		}
	
		public fun pop_back<E>(v: &mut T<E>): E {
			Vector::pop_back(&mut v.ls)
		}
	
	
		public fun destroy_empty<E>(v: T<E>) {
			let T { ls } = v;
			Vector::destroy_empty(ls);
		}
	
		public fun swap<E>(v: &mut T<E>, i: u64, j: u64) {
			Vector::swap(&mut v.ls, i, j);
		}
	
	}

	module amoeba_map {
		// use Std::Signer;
		use 0x2::Map;
		
		struct T<K, V>  has copy, drop, store {
			dic: Map::T<K, V>,
		}
		
		public fun empty<K, V>(): T<K, V> {
			T { dic: Map::empty() }
		}
		
		public fun get<K, V>(m: &T<K, V>, k: &K): &V {
			Map::get(&m.dic, k)
		}
		public fun get_mut<K, V>(m: &mut T<K, V>, k: &K): &mut V {
			Map::get_mut(&mut m.dic, k)
		}
		
		public fun contains_key<K, V>(m: &T<K, V>, k: &K): bool {
			Map::contains_key(&m.dic, k)
		}
		public fun insert<K, V>(m: &T<K, V>, k: K, v: V) {
			Map::insert(&m.dic, k, v);
		}
		public fun remove<K, V>(m: &T<K, V>, k: &K): V {
			Map::remove(&m.dic, k)
		}
	
	}
	
}



address 0x2 {

	module Map {
		native struct T<K, V> has copy, drop, store;
		
		native public fun empty<K, V>(): T<K, V>;
		
		native public fun get<K, V>(m: &T<K, V>, k: &K): &V;
		native public fun get_mut<K, V>(m: &mut T<K, V>, k: &K): &mut V;
		
		native public fun contains_key<K, V>(m: &T<K, V>, k: &K): bool;
		// throws on duplicate as I don't feel like mocking up Option
		native public fun insert<K, V>(m: &T<K, V>, k: K, v: V);
		// throws on miss as I don't feel like mocking up Option
		native public fun remove<K, V>(m: &T<K, V>, k: &K): V;
	}

}

