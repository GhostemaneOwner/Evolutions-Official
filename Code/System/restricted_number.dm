restricted_number
	var/minimum
	var/current
	var/maximum

	New(var/minimum = 0, var/current = 100, var/maximum = 100)
		src.minimum = minimum
		src.current = current
		src.maximum = maximum

	proc/set_current(var/number as num)
		number = max(src.minimum, number)
		number = min(src.maximum, number)
		src.current = number

	proc/reduce(var/number as num)
		set_current(src.current - number)

	proc/increase(var/number as num)
		set_current(src.current + number)

	proc/at_min()
		return src.current == src.minimum

	proc/at_max()
		return src.current == src.maximum
