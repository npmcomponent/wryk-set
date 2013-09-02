require! {
	Set: '../build/set'
	should
}

describe "new Set(iterable)" (...) !->
	s = new Set [NaN, +0, -0, 'a']

	it "should initialize values from iterable" !->
		s.has NaN .should.be.true
		s.has +0 .should.be.true
		s.has -0 .should.be.true
		s.has 'a' .should.be.true
		s.size.should.be.equal 4

	describe ".add(value)" (...) !->
		it "should add a new value to values" !->
			s.add 'b'
			s.has 'b' .should.be.true

		it "should value are unique and take care about NaN and zeros" !->
			s.size.should.be.equal 5
			s.add NaN
			s.size.should.be.equal 5

	describe ".delete(value)" (...) !->
		it "should remove a value to from values" !->
			s.has 'b' .should.be.true
			s.delete 'b'
			s.has 'b' .should.be.false

		it "should return true if a value are deleted" !->
			s.add 'c'
			s.delete 'c' .should.be.true

		it "should return false if a value are not deleted" !->
			s.delete 'c' .should.be.false


	describe ".has(value)" (...) !->
		it "should return true if value is added" !->
			s.has 'a' .should.be.true

		it "should return false if value is not added" !->
			s.has 'z' .should.be.false


	describe ".clear()" (...) !->
		it "should delete all values" !->
			s.clear!
			s.size.should.be.equal 0


	describe ".size" (...) !->
		it "should return the number of values" !->
			s.size.should.be.equal 0
			s.add 'a'
			s.size.should.be.equal 1

	describe ".forEach(callback [, context])" (...) !->
		it "should call callback for all entries with (value, set)" !->
			s.add -0
			s.add 1

			counter = 0
			s.forEach (value, set) !->
				counter++
				s.has value .should.be.true
				set.should.be.equal s

			counter.should.be.equal s.size

		it "should use context as current context" !->
			context = {}
			s.forEach do
				!-> @should.be.equal context
				context

	describe ".values()" (...) !->
		it "should return a set values iterator" !->

			iterator = s.values!

			while (value = iterator.next!) != null
				found = false

				s.forEach !-> found := true if it == value

				found.should.be.true