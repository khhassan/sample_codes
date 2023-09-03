```do
***********************************************

	* Make a new folder (or directory)

	mkdir "C:\Users\Dropbox (Personal)\Data\Outputs\New_folder"

	* folder "New_folder" will be created in above address 

	***********************************************
  
  * create blank data file of the type specified
 
	 ssc install touch
	 touch reg_data, type(dta) var(speed diff echalan one_variable road_numeric EW year_m month_m day_m ) replace 

	***********************************************

	findname can tell you which variables are completely non-missing, completely missing, and so forth.


```
