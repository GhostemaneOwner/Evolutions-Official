/obj/admins/proc/Create_Object_Menu()
	set name = "Create Object"
	set category = "Admin"
	set popup_menu = 0
	/*if(usr.client && !usr.client.holder)
		src << "Only administrators may use this command."
		return*/
	var/txt = {"<HTML><HEAD><TITLE>Spawn Object</TITLE></HEAD><BODY>
				<FORM NAME="Spawner" ACTION="byond://?src=\ref[src]" METHOD="GET">
				<b>Type:</b>  <INPUT TYPE="text" NAME="SearchBar" VALUE="" onKeyUp="updateSearch()" onKeyPress="submitFirst(event)" style="width:350px"><BR>
				<b>Offset:</b> <INPUT TYPE="text" NAME="offset" VALUE="x,y,z" style="width:250px">
				A <INPUT TYPE="radio" NAME="otype" VALUE="absolute">
				R <INPUT TYPE="radio" NAME="otype" VALUE="relative" checked="checked"><BR>
				Number: <INPUT TYPE="text" NAME="number"  VALUE="1" style="width:330px"><BR><BR>
				<SELECT NAME="ObjectList" id="ObjectList" size="20" multiple style="width:400px"></SELECT><BR>
				<INPUT TYPE="hidden" name="src" value="\ref[src]">
				<INPUT TYPE="submit" value="spawn">
				</FORM>
				<SCRIPT LANGUAGE="JavaScript">
					var OldSearch = "";
					var ObjectList = document.Spawner.ObjectList;
					var ObjectTypes = "[dd_list2text(typesof(/atom),";")]";
					var ObjectArray = ObjectTypes.split(";");
					document.Spawner.SearchBar.focus();
					populateList();
					function populateList()
					{
						var myElem;
						ObjectList.options.length = 0;
						for(myElem in ObjectArray)
						{
							var oOption = document.createElement("OPTION");
							oOption.value = ObjectArray\[myElem\];
							oOption.text = ObjectArray\[myElem\];
							ObjectList.options.add(oOption);
						}
					}
					function updateSearch()
					{
						if(OldSearch == document.Spawner.SearchBar.value) return;
						OldSearch = document.Spawner.SearchBar.value;
						ObjectArray = new Array();
						var TestElem;
						var TmpArray = ObjectTypes.split(";");
						if(OldSearch!=null) OldSearch = OldSearch.toLowerCase(); // Turn the search string into lowercase
						for(TestElem in TmpArray)
						{
							if(TmpArray\[TestElem\].toLowerCase().search(OldSearch) < 0) continue; //compare the lowercase entry to the lowercase search string for a match.
							ObjectArray.push(TmpArray\[TestElem\]);
						}
						populateList();
					}
					function submitFirst(event)
					{
						if(!ObjectList.options.length) return false;
						if(event.keyCode == 13 || event.which == 13)
							ObjectList.options\[0\].selected = 'true';
					}
				</SCRIPT></BODY></HTML>"}
	usr << browse(txt, "window=create_object;size=440x490")
