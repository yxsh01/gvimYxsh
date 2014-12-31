map <F11> call CodetoXML()<CR>
function CodetoXML()
	%s/^ *new KeyValuePair<string, string>(/<map Name=/
	%s/, *"/>/
	%s/").*$/<\/map>/
endfunction
