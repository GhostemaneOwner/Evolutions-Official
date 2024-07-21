client
	var/list/controlobjs = list()

	proc
		addControlObj(_name)
			if(!_name) return
			var/ControlObject/co = new /ControlObject(_name, src)
			controlobjs += co
			return co

		subControlObj(_name)
			if(!_name) return
			for(var/ControlObject/co in controlobjs)
				if(_name == co.name) del co

		getControlObj(_name)
			if(!_name) return
			for(var/ControlObject/co in controlobjs)
				if(_name == co.name) return co

ControlObject
	/* These Control Objects are saved in the client's ControlObjs list
	Their purpose is to store a data hierarchy for controls, allowing some flexibility
	in which kinds of data can be used in said controls
	It'll need an ID for the control
	*/

	var/name // store the name of the window here for lookup
	var/client/viewer
	var/maxx = 0
	var/maxy = 0

	var/list/gridData = list()
	// a 2D list with [col]x[row] as the format. "1" = list("1" = x, "2" = y, "3" = z), "2" = ...

	var/atom/reference // for use in passing along a relevant object to the control

	New(_name, client/c)
		..()
		name = _name
		viewer = c

	proc

		checkGrid(col)
			if(!islist(gridData["[col]"])) return 0
			else return 1

		expandGrid(col, row)
			if(!col || !row) return
			if(!checkGrid(col)) gridData["[col]"] = list()
			if(maxx < col) maxx = col
			if(maxy < row) maxy = row

		addGridData(col, row, data)
			if(!col || !data) return
			if(!maxx) maxx = 1
			if(!maxy) maxy = 1
			if(!row) row = maxy + 1
			expandGrid(col, row)
			gridData["[col]"]["[row]"] = data
			viewer << output(data, "[name]:[col],[row]")

		subGridData(col, row)
			if(!col || !row) return
			if(!checkGrid(col)) return
			gridData["[col]"]["[row]"] = null
			viewer << output(null, "[name]:[col],[row]")

		getGridData(col, row)
			if(!col || !row) return
			if(checkGrid(col)) return gridData["[col]"]["[row]"]

		getAllData()
			var/list/gd = list()
			for(var/x in gridData)
				var/list/col = gridData[x]
				for(var/y in col)
					gd += col[y]
			return gd // should be a 1D list with all entries

		updateGrid()
			for(var/x in gridData)
				for(var/y in gridData[x])
					viewer << output(gridData["[x]"]["[y]"], "[name]:[x],[y]")
			winset(viewer, name, "cells=\"[maxx],[maxy]\"")
			