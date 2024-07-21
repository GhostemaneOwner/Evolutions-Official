callback

	proc/Call(...)

	proc/Calls()
		return list(src)

	proc/operator~=(callback/other)
		return type == other.type

	proc/operator+(callback/other)
		return //new/callback/chain(Calls() + other.Calls())
//
	proc/operator-(callback/other)
		return src ~= other ? null : src
	callback/chain

	var/list/_calls

	proc/_Match(list/list, target)
		for(var/match in list)
			if(match ~= target)
				return match

	New(list/calls)
		..()
		if(!islist(calls))
			_calls = list(calls)
		else _calls = calls

	Call(...)
		for(var/callback/callback as anything in _calls)
			callback.Call(arglist(args))

	Calls()
		return _calls.Copy()

	operator+(callback/gain)
		return //new/callback/chain(_calls + gain.Calls())

	operator-(callback/loss)
		var/list/calls = _calls.Copy()
		for(var/callback in loss.Calls())
			calls -= _Match(calls, callback)
		switch(length(calls))
			if(0)
				return null
			if(1)
				return calls[1]
			else
				return ///new/callback/chain(calls)





proc/function(path)
	return new/callback/function(path)

callback/function

	var/_path

	New(path)
		..()
		_path = path

	Call(...)
		return call(_path)(arglist(args))

	operator~=(callback/function/other)
		return ..() && _path == other._path



datum
	proc/Method(path)
		return new/callback/method(src, path)

	proc/Callback(path, list/callback_args)
		return call(src, path)(arglist(callback_args))

callback/method
	parent_type = /callback/function

	var/datum/_source

	New(datum/source, path)
		..(path)
		_source = source

	Call(...)
		return _source?.Callback(_path, args.Copy())

	operator~=(callback/method/other)
		return ..() && _source == other._source
