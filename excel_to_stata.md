```do   

clear all
   set more off
   pause off
   local filelist: dir "." files "*.xl*", respectcase
   local num=0
   /* work on every file and temp-save it */
   foreach file of local filelist {
   
       import excel "`file'", clear
	   drop in 1/2
	   rename A plate_m
	   rename D drivingdirection_m1
	   rename E lane_m1
	   rename G passingtime_m1
	   drop B C F H
       tempfile file`++num'
       display as text in smcl  "working on file number {it:`num'}..."
       display as text in smcl  "... finished working on file number{it:`num'}"
       pause
	   local x=subinstr("`file'",".xls","",.)
	   sa "`x'_expo_E_W.dta", replace

   }
   
   
    fs *.dta
	di `: word count `r(files)''
	append using `r(files)'
	
	tab  drivingdirection_m1 , m
	
	
	drop drivingdirection_m1
	gen  drivingdirection_m1 = 1
	la define drivingdirection_m1 1 "Begum Road E to W"
	la values drivingdirection_m1 drivingdirection_m1

	destring lane_m1, replace force

	duplicates drop _all, force

	compress

	save begum_18_SN.dta, replace

	duplicates drop plate_m passingtime_m1 if plate_m!="Unlicensed" , force
    save "D:\P-S-C-A\PSCA-JOHAR_TOWN\Chowk Expo Center\expo_E_W.dta", replace
	
	gen keeper = 1 if strpos(drivingdirection_m1,"Begum Road E to W")!=0
	
	preserve 
	keep if keeper == 1
	sa bgum18_EW.dta , replace
	restore 
```
