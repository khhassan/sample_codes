```do

******************************

  fs *.dta
	di `: word count `r(files)''
	append using `r(files)'
	
	***********************************************

```
