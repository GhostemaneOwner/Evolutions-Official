// AbyssDragon's Library

proc/BubbleSort(list/L)
	for(var/i = L.len; i >= 1; i--)
		for(var/j = 1; j < i; j++)
			if(Compare(L[j], L[j+1]) == -1)
				Swap(L, j, j+1)
	//return L

proc/Compare(item1, item2)
	if(isnum(item1))
		return item2<item1?-1:(item1==item2?0:1)
	else
		return sorttextEx("[item1]", "[item2]")

proc/Swap(list/L, position1, position2)
	var/temp = L[position1]
	L[position1] = L[position2]
	L[position2] = temp
	