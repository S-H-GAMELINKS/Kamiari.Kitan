class Flag

    @@flag = 99

	def Flag.set(flag)
		@@flag = flag
	end

	def Flag.ref
		@@flag
	end
end

class Lineno

	@@lineno = 0

	def Lineno.set(lineno)
		@@lineno = lineno
	end

	def Lineno.ref
		@@lineno
	end
end