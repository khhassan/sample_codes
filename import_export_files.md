```do
***********************************************
   
   import delimited "D:\Housing_study\Zameen\zameen_gis.csv" , clear   // importig CSV file
   
   outsheet var1 var2 var3 var4 using "hedonicGIS_zone.csv", comma names replace // exporting CSV file

  ***********************************************
  
  * Importing and appending multiple csv files 
  
   clear all
   
   local y = 1
	
   cd "D:\Housing_study\zameen_scp_hassan\hassan_zam_URLs"

   local filelist: dir "." files "*.csv", respectcase

   foreach file of local filelist {
   
   import delimited "`file'" , clear 
   tempfile file_`y'
   sa      `file_`y''
   local `++y'

   }
   
    use `file_1', clear
	foreach q of numlist 2/`y' {
	cap append using `file_`q''
	}
   
  
  ***********************************************

```
