

	clear all
	set more off
	mat drop _all
	
	global CSV_folder = "C:\Users\Hassan\Dropbox\Satellite Imagery KP Pak Project\Kashmir\csv_files_kash"
	global drop_kash_table = "C:\Users\Hassan\Dropbox\Satellite Imagery KP Pak Project\Kashmir\tables_kashmir"
	
	import delimited "D:\CSV_files\ext20.csv" , clear
	
	keep key dn_ext_20
	
	tempfile fil
	  sa      `fil'
	
	cd "$CSV_folder" 
	
	import delimited kash_extend_dn.csv , clear // extracted from ArcGIS
	
	merge 1:1 key using  `fil'
	
	drop _merge
   
   export delimited using "C:\Users\Hassan\Dropbox\Satellite Imagery KP Pak Project\Kashmir\csv_files_kash\kash_extend_dn2.csv", replace
   
   
   *******************************
   
   
  clear all
   
   local y = 1
   
   cd "D:\modis (3)\modis\areaCSVFiles"
   
   foreach q in     "bagh"    "hattian"       "kotli"         "muzaffarabad" "poonch" ///
                 "bhimber" "haveli"       "mirpur" "neelum" "sudhnoti" {
				 
	 
				 
	   import delimited `q'.csv , encoding(ISO-8859-2) clear
	   
	   *sort value area
	   
	   gcollapse (sum) area  hec , by( value )
	   
	   *duplicates drop _all, force
	   
	   gen dis = "`q'"
	   
	   tempfile file_`y'
	   sa      `file_`y''
	   local `++y'
	   
	   }
   
   
   
   di "`y'"
   
    use `file_1', clear
	foreach q of numlist 2/`y' {
	cap append using `file_`q''
	}
  clear all
   
   local y = 1

   foreach i of numlist 1/7  {
   
   cd "C:\Users\Hassan\Downloads\modis_2020\Shape_files+Area_files\areatype`i'"
   
	   foreach q in "BAGH"  { // "BHIMBER" "HATTIAN" "HAVELI" "KOTLI" "MIRPUR" "MUZAFFARABAD" "NEELUM" "POONCH" "SUDHNOTI"
	   
	   import delimited stype`i'DISTRICT_BAGH.csv , encoding(ISO-8859-2) clear
	   
	   sort value area
	   
	   gcollapse (sum) area , by( value )
	   
	   *duplicates drop _all, force
	   
	   gen dis = "`q'"
	   
	   tempfile file_`y'
	   sa      `file_`y''
	   local `++y'
	   
	   }
   
   }
   
   di "`y'"
   
    use `file_1', clear
	foreach q of numlist 2/`y' {
	cap append using `file_`q''
	}
	
	sort dis value area
	
	gcollapse (sum) area , by( dis value )
	
	gen area_hec = area * 0.0001
	
	





import delimited "C:\Users\Hassan\Downloads\modis_2020\Shape_files+Area_files\areatype1\stype1DISTRICT_BAGH.csv", encoding(ISO-8859-2) 
	
	
	codebook area
	codebook value
	
	cd "C:\Users\Hassan\Downloads\modis_2020\Shape_files+Area_files\areatype1"
	
	 local filelist: dir "." files "*.csv", respectcase

   foreach file of local filelist {
   
   di "`file'" 

   }
   ***********************************************

	levelsof ToT1_ID, local(levels)
	foreach i of local levels {
	   cap confirm var t2_`i'     // checking/confirming whether or not this variable exists in dataset
	   if c(rc) == 111 {          // VARIABLE NOT FOUND
			gen t2_`i' = 0
		}
	}

	cap xtile dec2 = dis98_Haveli, nq(100)
	   if c(rc) == 2000 {      // NO OBS FOUND
			di "error"
		}
		
		
   ***********************************************
   
   	gen v3 = .
	gen v4 = .

	tokenize "18 15"

	foreach v of var v3-v4 {
		rename `v'  preday`1'
		mac shift
	}

https://www.stata.com/statalist/archive/2002-10/msg00374.html
   
    
   
   ***********************************************
   
   
	foreach name in "Emerging Urban" "Mega Cities" "Rural" "Urban" {
	
	#delimit ;
		  graph box pc_year_actual if category == "`name'", over(Year)
		  title("Figure 1: Emissions by Province by Year", span color(red))
		  note("`name'", span);
	#delimit cr
	
	}


     ***********************************************

		clear 
		
		cd "D:\full_vio_data_29_Sep_21"
		
        foreach name in   "ghazi chowk (college road)" { // need changing
		
		use "`name'" , clear
		
		foreach i of numlist 1021 {   // need changing
		
		local num = `i'
		
		recode inter_name (1 = `i') , gen(inter_id) label(inter_name)
		
		elabel recode inter_name (1 = `i') , define( inter_id )
		
		la values inter_id inter_id

		}
		
		drop inter_name
		
		la var inter_id ""
		
        sa  "`name'" , replace
		
		shell ren "`name'.dta" "`num'_`name'.dta"
		
		}

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
  
    translate "C:\Users\Hassan\Desktop\total_vio_data_convert.do" pdffile, translator(txt2pdf)
  
  ***********************************************
  
	foreach i of numlist 1/58 {
			
	local f`i': label encode_type_str `i'
	la var stu`i' "`f`i''"
	
	}
	
	foreach i of numlist 1/34 {
		
		local v : label (encode_place) `i'
		local vv = subinstr("`v'", " ", "_", .) //  2nd argument is space, 3rd is underscore, signifying spaces replaced with underscores 
		local vv = subinstr("`vv'", "(", "", .)
		local vv = subinstr("`vv'", ")", "", .)
    }
	  
	  
	  local lab`i': variable label indicator`i' 
	  
	  if strpos( PersonalIncome, "Income")!=0
		   
		   
  local section=substr("`file'",3,3) // takes out 1_2 from A_1_2_class_EW
  gen  section=substr(plate_m,-1,1) 
  gen plate_len = length(plate_m ) // length of string variable
  gen  last_letter =substr(plate_m,-1,1)
  
  replace ebcode=proper(itrim(trim(ebcode)))
  
  ***********************************************
  
  clonevar area_copy = area

	egen N1= sieve( area ), char(MARLAmarlaKANALkanal)
	egen N2 = sieve( area ), char(,.0123456789)

	destring  N2 ,  force replace
	
  ***********************************************
  
  * remove special characters from string ( 12,000  >>>  12000 )
  
  replace oldstring = subinstr(oldstring, "-", "",.)
  
  
   foreach n in "A" "B"  "C" "D" "E" "F" "G" "H"  "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" {
   replace plate_m2 = subinstr(plate_m2, ""`n''"", "",.)
 }
   ***********************************************
   
 gen postcode = substr( plate_m ,1,length( plate_m )-1) if inrange(substr( plate_m ,-1,1), "a","z")
 
 plate_m   postcode
 
 led4512a  led4518
 lfd845c   lfd845
 
 ***********************************************
 
 gen string_comma = string(numeric, "%10.0fc")
 
 numeric  string_comma
  61467	   61,467
 

  ***********************************************
  
  local show = "`: display %5.2f 2.12745678'"

di `show'
2.13

tostring var, gen(new_var)  format(%5.0f) force  //  make numeric to string with rounded to 0 decimal place

  ***********************************************
  
  local x = "aa bb cc"
		
  di `: word count `x'' // counts number of words in local
    
  ***********************************************
  
 gen postcode = substr( inter_name ,1,length( inter_name )-10)
 
 inter_name	          postcode
 
 akbar_18_EW.dta	  akbar
 askari10_19_EW.dta	  askari10

  
***********************************************

gen double      newdate = mdy( month_m , day_m , year_m )
		quietly replace newdate = dhms(newdate , hr_m  , min_m , sec_m )
		gen date_time = string( newdate ,"%tc")
		gen double event_m = clock( date_time ,"DMY hms")
		
		di td(01jan2020) // 21915
		di td(01nov2020) // 22220

***********************************************
		
filelist , dir("F:\kp_dis")

dirname	   filename      	fsize

F:\kp_dis	abtobad_poi.csv	341656
F:\kp_dis	bannu_poi.csv	254293
F:\kp_dis	batag_poi.csv	165613
F:\kp_dis	buner_poi.csv	212977
F:\kp_dis	charsa_poi.csv	154026
F:\kp_dis	chitral_poi.csv	1813104
F:\kp_dis	dismail_poi.csv	1636598
F:\kp_dis	hangu_poi.csv	253203
F:\kp_dis	haripur_poi.csv	258140

***********************************************

     cd "D:\ps-ca_usb"
		
     folders  //  lists the names of folders or directories in compact form

    `r(folders)'

***********************************************

    * Current time and date *

	di c(current_date)
	14 Jun 2021

	di c(current_time)
	20:01:12

	local D = c(current_date)
	local T = c(current_time)
	local T = subinstr("`T'",":","_",.)
	di "`T'"

	
	    gen Date = mdy( month , day , year )  //  all three date components : day, month, year
		format Date %dM_d,_CY
		
		gen date2 = mdy( month , day , year ) // one date component : day
		format date2 %tdDay
		
		gen date3 = mdy( month , day , year ) //   two date component : day, month
		format date3 %tdd_m
		
		gen dow = dow( date2 ) // Day of week:  0 = Sunday , 1 = Monday and so on 
		
		la define dow 0 "Sunday" 1 "Monday" 2 "Tuesday" 3 "Wednesday" 4 "Thursday" 5 "Friday" 6 "Saturday" , modify
	    la values dow dow
		
		la define month 1 "Jan" 2 "Feb" 3 "Mar" 4  "Apr" 5 "May" 6 "Jun" 7 "Jul" 8 "Aug" 9 "Sep" 10 "Oct" 11 "Nov" 12 "Dec" , modify
	
***********************************************

    fs *.dta
	di `: word count `r(files)''
	append using `r(files)'
	
	***********************************************
	
	* removes "a_" from all variables names
	
	* a_varname ---> varname
	
	renpfix a_ 
	
	***********************************************
	
	
	* Insert gap observations in a data set   (Roger Newson)
	
	findit ingap
	
	ingap 1 , after // adds empty row after first row/observation
	
	***********************************************
	
	* Insert empty observation at the end of data set 
	
	set obs `=_N+1' 
	
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

	***********************************************

	ssc install shp2dta

	converts shapefile to stata dataset 

	* for calculating distances between latitudes and longitudes 

	ssc install geodist
	ssc install geodist2
	ssc install geonear 

        ******* calculating distance from center *********
		******* for each zameen.com home *****************

		gen latlhr  = 31.5341068689424  						    // latitude of CBD
		gen longlhr = 74.336454560294   					    	// longitude of CBD
		
		geodist geography_ geography1 latlhr longlhr, gen(distance)
		
		******************************************
		
 ssc install geoinpoly

 geoinpoly returns, in a variable named _ID, the identifier of a polygon from coordinates_file that spatially overlays a point defined by latitude and longitude.
 
 ssc install geocircles
 
 geocircles creates polygons that approximate the shape of circles. 
 
  findit fieldarea  //  Compute area of irregular field from GPS coordinates of its vertices. http://www.radyakin.org/stata/fieldarea/fieldarea.htm
 
**************************************************

* Fisrt use "Conversion tools from raster to ASCII" in ArcGIS 
* convert raster to file with .asc format
* then use following commands  
 
cd "D:\ascii_raster"

ras2dta , files(urban_lhr) xcoord(3711) ycoord(3711) genxcoord(column_id) genycoord(row_id) replace

**************************************************

ssc install listutil

local cty 112 132 134 136 156 158 111

 di  `cty'
112132134136156158111

 di  "`cty'"
112 132 134 136 156 158 111

local ncty = `r(nw)'

di `ncty' 
7

rotlist `cty', rot(-1)

local now `r(list)'

di "`now'"
111 112 132 134 136 156 158

takelist `now',pos(2)

local dep `r(list)'

 di `dep'
112

**************************************************

scalar s1 = `"xi: xtreg ln_clean_ind_ser_gdp  ln_All  if inlist(year,"GF","JIK") ,  fe robust cluster( state_encode)"'
di s1

local s1 = `"xi: xtreg ln_clean_ind_ser_gdp  ln_All  if inlist(year,"GF","JIK") ,  fe robust cluster( state_encode)"'
di s1


**************************************************

* local in a global

		foreach i of numlist 1/5 {
		 global yxiv`i'  "speed echalan EW predict_`i'" 
		 }		
		 
	 foreach v of numlist 1/5 {	 
	${yxiv`v'} 
     }

**************************************************

	ssc install egenmore
	egen N = sieve( string_variable ), char(-.0123456789) // take out these character from string variable
	destring  N, replace

**************************************************

collapse (sum) variable, by(foreign)

* There is a fast option to Stata's collapse (9-300 times faster in IC and 4-120 times faster in MP), with several additions.

ssc install gtools
gtools, upgrade
gcollapse (sum) variable, by(foreign)

* fcollapse has append option where the collapsed data is saved at the end of dataset. 
* So you can collapse by many things and not having to preserve/save 

ssc install ftools
ssc install moremata
fcollapse (sum) variable , by(foreign) append

fcollapse (sum) price ,  append // adds total row to the end of dataset

*************************************************

22.12345

di round(e(b)[1,1], .01) // round to 2 decimal place
22.12

di round(e(b)[1,1], .1) // round to 1 decimal place
22.1

di round(2.5265, 1) // round to 0 decimal place
3

local show = "`: display %5.2f 2.12745678'"

di `show'
2.13

tostring var, gen(new_var)  format(%5.0f) force  //  make numeric to string with rounded to 0 decimal place


**************************************************


	total traffic_hr   // calculates sum of the variable
	matrix list e(b)   // displays stored result (sum) in matrix form
	e(b)[1,1]          // displays stored result (sum) 

set obs `=_N+1'   // adding one row to the end of data

replace n_2_1=e(b)[1,1] if n_2_1==.

***************************************************

asdoc sum, save(C:\Users\hassa\Desktop\psca_2020\EW_ttests.doc)
asdoc ttest variable  , by(echalan)  title(conducting ttests) append
mat ttest_matrix = r(T)

***************************************************

mat single = J(1,1,`t')

***************************************************

matnames f // extracts col names in local

***************************************************

matrix A0 = (5,5)
matrix A1 = (1,2)
matrix A2 = (3,4)
matrix ALL = A0

foreach i of numlist 1/3{
cap matrix ALL = ALL\A`i'   // vertical appending of matrices
}

cap mat CCC = AAA\ /// // dddf
        BBB\FFF

***************************************************

matrix A = ( 1 \ 7 \ 5 )
matrix B = ( 12 \ 77 \ 58 )

mat C = A , B
mat colnames C = year ntl_value bg_value  // renaming column names of the matrix 

***************************************************

 mat define A = (1,2,42) 

 local dim (`= rowsof(A)',`=colsof(A)') 

 di "`dim'" 
 
 local dim_m2 (`= rowsof(A)',`=colsof(A)') 
	
  di "`dim_m2'" 
  
***************************************************

STB-56 dm79.
ssc install svmatf

* svmatf saves a matrix as a dataset. It can be saved
* as a separate dataset - or it can be added to an existing dataset.

* svmatf can be used to store a series of related matrices 
* stacked on top of each other in one file. 

matrix A2 = (3,4)
svmatf , mat(A2) row(row_var) fil(A2.dta)

matrix A3= (8,3)
svmatf , mat(A3) row(row_var) fil(A2.dta)

Following is "A2.dta" data with both matrices appended :

c1	c2	row_var
3	4	r1
8	3	r1

***************************************************

matrix Ac = ( nullmat(Ac), 1, 2)
mat list Ac
matrix Ac = ( nullmat(Ac), 8, 5)
mat list Ac

Ac[1,4]

    c1  c2  c3  c4
r1   1   2   8   5

***************************************************

matrix CV = ( nullmat(CV)\ 2\3)
mat list CV
matrix CV = ( nullmat(CV)\ 8\6)
mat list CV

CV[4,1]

    c1
r1   2
r2   3
r3   8
r4   6

***************************************************

    matrix A = ( 1 , 4, 65 \ 7, 5, 63 \ 5 ,58, 36 ) // 3x3 matrix 
	
	mat list A

	forvalues i = 1/3 {
		matrix A[`i',`i']= A[`i',`i'] * 0 // replace diagonal entries of matrix with 0
	}
    
	matrix A = ( 1 , 4, 65 \ 7, 5, 63 \ 5 ,58, 36 )
	
	mat list A

***************************************************
	
	tabstat  member_avg_inc_* , stat(n sum)  columns(statistics)   save
	
	mat list r(StatTotal)
	mat tr_sum = r(StatTotal)' // transposing matrix of sum stats
	
	matrix coltotal = J(1, rowsof(tr_sum), 1) * tr_sum

***************************************************
	
local year = 1992
foreach i of numlist 1/29 {
matrix yearm = ( nullmat(yearm)\ `year')
local `++year'
}
mat list yearm // column matrix of time-series 

***************************************************

    mkmat   echalan  speed diff violation if original_data ==. , matrix(road_`i')  rownames(road_decode)
	svmatf , mat(road_`i') row(road) fil(stats_1_direction.dta)
		
asdoc sum, save(C:\Users\hassa\Desktop\psca_2020\EW_ttests.doc)
asdoc ttest variable  , by(echalan)  title(conducting ttests) append
mat A = r(T)
mat row = (`j')
mat A = row, A
svmatf , mat(A)  fil(time_all.dta)

***************************************************

	ssc install matsave

	* matsave saves a matrix from memory to disk as a Stata dataset (matrix.dta)

	matsave matrix_name , replace saving  path(C:\Users\hassa\Desktop\psca_2020)

***************************************************

	xsvmat is an extended version of svmat.  It creates an output dataset

***************************************************

	matrix A = ( 1 , 4, 65 \ 7, 5, 63 \ 5 ,58, 36 ) 
	mat list A
	heatplot  A, backfill colors(plasma) cuts(1 5 10 40 50 60 70)

***************************************************
   
   centile VARIABLE if road_encode == `j',  centile( 15 50 85 )
   local fast = `r(c_3)' - `r(c_2)' // 85th percentile - median
   local slow = `r(c_2)' - `r(c_1)'  // median - 15th percentile
   
***************************************************

mat colnames MATRIX_NAME = road avg 85_p greater slow fast N  // renaming column names of the matrix 

matnames MATRIX_NAME   // matnames returns matrix row and column names as locals in r(). 

***************************************************
	
matname G Beta,  c(1) explicit  // rename column 1 of matrix G to "Beta"
	
***************************************************

ERROR:

file Stats Table - Peak uni.dta cannot be modified or erased; likely cause is
    read-only directory or file

 If the file you are saving is (or becomes) very large, and the loop otherwise executes quickly, 
 it is possible that the operating system is not done writing out the last version of the file 
 (disk output is very slow compared to computation) when it gets Stata's next request to write 
 out the next version, and at that point the OS may tell Stata the file is inaccessible because it is still busy.

If this is what is happening, the solution is to put a -sleep- command into the loop just after 
the -save- command. That will make Stata wait long enough for the file-write operations to completely 
finish before proceeding to the next iteration of the loop. You will need to do some trial-and-error 
to find out just how much sleep time is needed. I'd start with 500 milliseconds and go up from there 
until the loop consistently runs without failure.
	
sleep 900 // 2 seconds wait before running next command (1000 ms = 1 sec)
	
***************************************************

filling missing values in numeric or string variables with
 the variable's previous value, forward value, first or last
 value, or with some calculated values such as mean,


ssc install fillmissing
 fillmissing VARIABLE , with(any)
 
 ***************************************************
 
 ssc install vtokenize
 
 reshape8 improves reshape by preserving variable labels as much as possible 
 when switching back and forth between long and wide dataset formats
 
 ********************************************
 
 ssc install nearmrg
 
 
 nearmrg performs nearest match merging of two datasets on the values of the
numeric variable nearvar.
 
 
  ********************************************
 
 
 cd "C:\Users\hassa\Dropbox (Personal)\Satellite Imagery KP Pak Project\Data\KP_districts_pixels"

local y = 1
foreach i in "pesh" "kohat" "dismail" "abtobad" "hangu" "mardan" "noshera" "swat" {

import delimited `i'_neartable.csv, clear


gen district_name = ""
gen number = `y'
replace district_name = "Peshawar" if number == 1
replace district_name = "Kohat" if number == 2
replace district_name = "DI.Khan" if number == 3
replace district_name = "Abbottabad" if number == 4
replace district_name = "Hangu" if number == 5
replace district_name = "Mardan" if number == 6
replace district_name = "Noshera" if number == 7
replace district_name = "Swat" if number == 8
drop number 

tempfile file_`y'
sa      `file_`y''
local `++y'
}

use `file_1', clear
foreach q of numlist 2/8 {
append using `file_`q''
}

 
 ***************************************************
	
	* Data sample for graph
	
	one_var	group_month_year  growth_cam_vio
	13   	1	
	10179	2	78200
	212778	3	1990.363
	207720	4	-2.377126
	137482	5	-33.81379
	123225	6	-10.37008
	164774	7	33.71799
	248338	8	50.71431
	261550	9	5.320168
	285821	10	9.279679
	239133	11	-16.3347
	234926	12	-1.759272
	274986	13	17.05218
	247725	14	-9.913595
	215593	15	-12.97083
	77961	16	-63.83881
	49754	17	-36.18091
	128728	18	158.7289
	136677	19	6.175036
	72119	20	-47.23399
	63132	21	-12.46135
	55382	22	-12.27587
	93146	23	68.18822
	189354	24	103.2873
	204100	25	7.78753
	4859	26	-97.6193
	198570	27	3986.643
	152091	28	-23.40686

	
	
	twoway ( bar one_var group_month_year if inrange(group_month_year,4,25), yaxis(2)  ylabel(#3, axis(2)) ytitle(Number, axis(2)) xtitle(month)  fintensity(inten30)  ) ///
	           ( scatter growth_cam_vio group_month_year if inrange(group_month_year,4,25),  connect(l) yaxis(1) ytitle(Percent, axis(1)) ) ///
	           ( lfit growth_cam_vio group_month_year if inrange(group_month_year,4,25)) ///
			   , legend( order(1 "# violations" 2 "Growth rate" 3 "Fitted growth line")) ///
					 title("Camera violations per month w.r.t time" "$v")    ///
					 note("Note: Violations identified by PSCA camera") ///
					 plotregion(fcolor(white))  graphregion(fcolor(white) style(none) color(gs16)) ylab(,nogrid) 
					 
					 
	twoway ( bar one_var group_month_year if inrange(group_month_year,4,25), yaxis(2)  ylabel(minmax, axis(2)) ytitle(Number, axis(2)) xtitle(month)  fintensity(inten30)  ) ///
	           ( scatter growth_cam_vio group_month_year if inrange(group_month_year,4,25),  connect(l) yaxis(1) ytitle(Percent, axis(1)) ) ///
	           ( lfit growth_cam_vio group_month_year if inrange(group_month_year,4,25)) ///
			   , legend( order(1 "# violations" 2 "Growth rate" 3 "Fitted growth line")) ///
					 title("Camera violations per month w.r.t time" "$v")    ///
					 note("Note: Violations identified by PSCA camera") ///
					 plotregion(fcolor(white))  graphregion(fcolor(white) style(none) color(gs16)) ylab(,nogrid) 
	
      global v : label (inter_name) 1
	  global vv = subinstr("$v", " ", "_", .) //  2nd argument is space, 3rd is underscore, signifying spaces replaced with underscores 
	    
	  twoway 
	  cap graph export ${vv}.png , replace width(3500) height(2400)	
	
	
	  * histogram with overlapped bars = green over transparent
	
		 twoway (histogram dn_h92 if district_encode==26, freq start(0) width(1) color(green)) ///
                (histogram dn_h13 if district_encode==26, freq start(0) width(1) fcolor(none) lcolor(black)), ///
	            xline(13) ///
	            legend(order(1 "1992" 2 "2013" )) title("Peshawar") xtitle("DN values")
		 graph export "C:\Users\hassa\Dropbox (Personal)\Satellite Imagery KP Pak Project\Data\Outputs\Histogram_pesh.png", replace width(3000) height(2200)
		 
		 
		 
 ***************************************************
 
		local t = 5
		local tt = `t' + 1
		local ttt = `t' + 2
		local tttt = `t' + 3
		foreach i of numlist 1/23 {
	    replace 15_min_int = `t' if hr_m`j' == `i' &  inrange( min_m`j', 1,15)
		replace 15_min_int = `tt' if hr_m`j' == `i' &  inrange( min_m`j', 16,30)
		replace 15_min_int = `ttt' if hr_m`j' == `i' &  inrange( min_m`j', 31,45)
		replace 15_min_int = `tttt' if hr_m`j' == `i' &  inrange( min_m`j', 46,60)
		local `t'=`t'+4
		local `tt'=`tt'+4
		local `ttt'=`ttt'+4
		local `tttt'=`tttt'+4
		}
		
		
		local i=0
		foreach a of numlist 1/20 {
		local i=`i'+4
		di `i'
		}


		preserve
        reg speed_`g' echalan i.road_encode i.interval_`g'
		regsave, pval
		drop stderr
		regsave_tbl , name(avg_speed_`g')
		tempfile  rs`g'
		sa       `rs`g''
		restore 
		reg speed_`g' echalan i.road_encode i.interval_`g'   if inrange(hour, 8, 17)
		regsave, pval
		drop stderr
		regsave_tbl , name(avg_speed_`g')
		tempfile  r2s`g'
		sa       `r2s`g''
		*/
		
		eststo: quietly reg speed_`g' echalan i.road_encode i.interval_`g'
		eststo: quietly reg speed_`g' echalan i.road_encode i.interval_`g' if inrange(hour, 8, 17)
		esttab, p ar2 replace obslast drop(*interval* 1.road*)
		mat list  r(coefs)
		svmat r(coefs), names(eqcol)
		gen RN = _n
		forval i = 1/`=rowsof(r(coefs))' { 
		*di  `i' 
		la define RN `i' "`: word `i' of `: rownames r(coefs)''", modify
		} 
		la values RN RN
		keep in 1/`=rowsof(r(coefs))'
		
		/*use `rs15', clear
		merge 1:1 var using `rs30' , gen(m_1)
		merge 1:1 var using `rs60' , gen(m_2)
		merge 1:1 var using `rt15' , gen(m_3)
		merge 1:1 var using `rt30' , gen(m_4)
		merge 1:1 var using `rt60' , gen(m_5)
		merge 1:1 var using `rv15' , gen(m_6)
		merge 1:1 var using `rv30' , gen(m_7)
		merge 1:1 var using `rv60' , gen(m_8)
		drop m_*
		drop if strpos( var, "b.")!=0
		drop if strpos( var, "interval_")!=0
		destring avg_*, force replace
		*/

***************************************************	
	
	cd "LS\PSCA_MALL_RD_2018\SN\clean_data"
	fs
	return list 
	foreach f in `r(files)' {
		    local file_name = "`f'"
		    if "`file_name'"=="A`j'_clean_SN.dta" {
		    append using "`user':\LS\PSCA_MALL_RD_2018\SN\clean_data\A`j'_clean_SN.dta"
			}
		}	

	cd "F:\LS\PSCA_MALL_RD_2018\EW\clean_data"
    fs *.dta
	append using `r(files)'
	
	cd "C:\PSCA\MALL_ROAD_2018\chkregdata"
		
        fs reg_mean*.dta    reg_p50*.dta    reg_p85*.dta
	    append using `r(files)'
		
		
		fs reg_mean*.dta reg_p50*.dta reg_p85*.dta
        foreach f in `r(files)' {
             erase `f'
         }
	
	
	
	foreach i of numlist 1 3 4 5 6 7 18/25  27 28 34 35 36 {

	tabm NR_Training_B3  NR_Training_B5A  NR_Training_B4  ///
		 NR_Training_B6  NR_Training_B6A  NR_Training_B6B  ///
		 NR_Training_B6C NR_Training_B8 if NR_Training_T2==`i', row matcell(freq)  matrow(names)

		 matrix list freq
		 matrix list names

		 putexcel A1=("ques")  K1=("total") L1=("always_prop") using res_`i', replace
		 putexcel A2=matrix(names) B2=matrix(freq)  using res_`i', modify

	putexcel  K2 = formula(=SUM(B2:J2))      ///
			  K3 = formula(=SUM(B3:J3))      ///
			  K4 = formula(=SUM(B4:J4))      ///
			  K5 = formula(=SUM(B5:J5))      ///
			  K6 = formula(=SUM(B6:J6))      ///
			  K7 = formula(=SUM(B7:J7))      ///
			  K8 = formula(=SUM(B8:J8))      ///
			  K9 = formula(=SUM(B9:J9)) using res_`i', modify
			  	  
	putexcel  L2 = formula(=(B2/K2)*100)      ///
			  L3 = formula(=(B3/K3)*100)      ///
			  L4 = formula(=(B4/K4)*100)      ///
			  L5 = formula(=(B5/K5)*100)      ///
			  L6 = formula(=(B6/K6)*100)      ///
			  L7 = formula(=(B7/K7)*100)      ///
			  L8 = formula(=(B8/K8)*100)      ///
			  L9 = formula(=(B9/K9)*100)  using res_`i', modify 
			  
	}
	
	
***************************************************
********  LATEX commands ****************************
***************************************************


***************************************************

	if	"`c(username)'" == "Michael"	{
		global		rootdir "C:\Users\Michael\Dropbox\Punjab Procurement\Data\_New Structure"
	}
	else	if	"`c(username)'" == "bestm"		{
			global		rootdir "C:\Users\bestm\Dropbox\Punjab Procurement\Data\_New Structure"
		}

global		codedir		"${rootdir}\Code\Info & Training Sessions"
global		rawdatadir	"${rootdir}\Raw Data"
global		ourdatadir	"${rootdir}\Stata Data\Info & Training Sessions"

log 		using 		"${codedir}\LogDDOInfoSurvey_&S_DATE", text replace

global		DataDate  	"20140721"

***************************************************




egen sum_x = sum(flow), by(iso_o)

scalar b_colony = .84
scalar b_comcur = .98
scalar b_home = 1.55
 
scalar list

gen  phi_in = exp(b_ldis*ldis  + b_lang*lang  + b_colony*colony + b_rta*rta + b_comcur*comcur + b_home*home)








 ren diff time
		
		*88	
		
		foreach w in time speed violations {
		foreach y of numlist 15 30          {
		
		if "`w'"=="time" {
		local `w'_ytitle = "Seconds"
		}
		if "`w'"=="speed" {
		local `w'_ytitle = "Speed - km / h"
		}
		if "`w'"=="violations" {
		local `w'_ytitle = "Number"
		}
		 
		preserve 
		cap bys echalan interval_`y' : egen MEAN=mean(`w')
	    duplicates drop month_m day_m hr_m`j' interval_`y'  `w'_`y' , force
		
		if "`w'"=="time" {
		tempfile  tt`y'_`j'_`i'
		sa       `tt`y'_`j'_`i''
		}
		if "`w'"=="speed" {
		tempfile  st`y'_`j'_`i'
		sa       `st`y'_`j'_`i''
		}
		if "`w'"=="violations" {
		tempfile  vt`y'_`j'_`i'
		sa       `vt`y'_`j'_`i''
		}
		
		if "`w'"=="violations" {
		bys echalan interval_`y' : egen MEAN=mean(`w'_`y')
		}		
		duplicates drop  echalan interval_`y' MEAN , force
	    cap asdoc ttest MEAN  , by(echalan)               
		
		if "`w'"=="time" {
		cap mat mt_`y'_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat mt_`y'_`j'_`i' = row, mt_`y'_`j'_`i' 
		cap svmatf , mat(mt_`y'_`j'_`i')  fil(time_all.dta)
		}
		if "`w'"=="speed" {
		cap mat ms_`y'_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat ms_`y'_`j'_`i' = row, ms_`y'_`j'_`i' 
		cap svmatf , mat(ms_`y'_`j'_`i')  fil(speed_all.dta)
		}
		if "`w'"=="violations" {
		cap mat mv_`y'_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat mv_`y'_`j'_`i' = row, mv_`y'_`j'_`i' 
		cap svmatf , mat(mv_`y'_`j'_`i')  fil(violations_all.dta)
		}
		
		cap asdoc ttest MEAN if inrange(hr_m`j', 8, 17) , by(echalan)  
		
		if "`w'"=="time" {
		cap mat at_`y'_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat at_`y'_`j'_`i' = row, at_`y'_`j'_`i' 
		cap svmatf , mat(at_`y'_`j'_`i')  fil(time_cut.dta)
		}
		if "`w'"=="speed" {
		cap mat as_`y'_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat as_`y'_`j'_`i' = row, as_`y'_`j'_`i' 
		cap svmatf , mat(as_`y'_`j'_`i')  fil(speed_cut.dta)
		}
		if "`w'"=="violations" {
		cap mat av_`y'_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat av_`y'_`j'_`i' = row, av_`y'_`j'_`i' 
		cap svmatf , mat(av_`y'_`j'_`i')  fil(violations_cut.dta)
		}
		
		if "`make_graph'" == "1" {
		twoway (scatter MEAN interval_`y' if echalan == 0,  connect(l)  msymbol(T)) (scatter MEAN interval_`y' if echalan == 1,  connect(l) msymbol(Oh)), ///
		       legend(rows(2) label(1 "Before e-chalan") label(2 "After e-chalan")) ///
		       title("Average `w' per `y'-min interval" "`n_`j'' $direct") xtitle(`y'-min interval) ytitle(``w'_ytitle') ///
		       plotregion(fcolor(white))  graphregion(fcolor(white) style(none) color(gs16))  ylab(,nogrid)
		graph save "C:\Users\hassa\Desktop\psca_2020\\`w'_per_`y'_`j'_`i'_$direct", replace 
		}
		
		restore   //`n_`j'_`i''
        }
				
		preserve
		cap bys echalan hr_m`j' : egen MEAN=mean(`w')
		duplicates drop month_m day_m hr_m`j'  `w'_60 , force 
		clonevar interval_60 = hr_m`j'
		
		if "`w'"=="time" {
		tempfile  tt60_`j'_`i'
		sa       `tt60_`j'_`i''
		}
		if "`w'"=="speed" {
		tempfile  st60_`j'_`i'
		sa       `st60_`j'_`i''
		}
		if "`w'"=="violations" {
		tempfile  vt60_`j'_`i'
		sa       `vt60_`j'_`i''
		}
		
		if "`w'"=="violations" {
		bys echalan  interval_60 : egen MEAN = mean(`w'_60)
		}
		duplicates drop  echalan interval_60 MEAN , force
		cap asdoc ttest MEAN  , by(echalan)  
		
		if "`w'"=="time" {
		cap mat mt_60_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat mt_60_`j'_`i' = row, mt_60_`j'_`i' 
		cap svmatf , mat(mt_60_`j'_`i')  fil(time_all.dta)
		}
		if "`w'"=="speed" {
		cap mat ms_60_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat ms_60_`j'_`i' = row, ms_60_`j'_`i' 
		cap svmatf , mat(ms_60_`j'_`i')  fil(speed_all.dta)
		}
		if "`w'"=="violations" {
		cap mat mv_60_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat mv_60_`j'_`i' = row, mv_60_`j'_`i' 
		cap svmatf , mat(mv_60_`j'_`i')  fil(violations_all.dta)
		}
		
		cap asdoc ttest MEAN if inrange(interval_60, 8, 17) , by(echalan) 
		
		if "`w'"=="time" {
		cap mat at_60_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat at_60_`j'_`i' = row, at_60_`j'_`i' 
		cap svmatf , mat(at_60_`j'_`i')  fil(time_cut.dta)
		}
		if "`w'"=="speed" {
		cap mat as_60_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat as_60_`j'_`i' = row, as_60_`j'_`i' 
		cap svmatf , mat(as_60_`j'_`i')  fil(speed_cut.dta)
		}
		if "`w'"=="violations" {
		cap mat av_60_`j'_`i' = r(T)
		cap mat row = (`j')
		cap mat av_60_`j'_`i' = row, av_60_`j'_`i' 
		cap svmatf , mat(av_60_`j'_`i')  fil(violations_cut.dta)
		}
		
		if "`make_graph'" == "1" {
		twoway (scatter MEAN interval_60 if echalan == 0,  connect(l)  msymbol(T)) (scatter MEAN interval_60 if echalan == 1,  connect(l) msymbol(Oh)), ///
		       legend(rows(2) label(1 "Before e-chalan") label(2 "After e-chalan")) ///
		       title("Average `w' per hour" "`n_`j'_`i'' $direct") xtitle(Hour) ytitle(``w'_ytitle') ///
		       plotregion(fcolor(white))  graphregion(fcolor(white) style(none) color(gs16)) ylab(,nogrid)
		graph save "C:\Users\hassa\Desktop\psca_2020\\`w'_per_hr_`j'_`i'_$direct",  replace
		}
		restore
		}
				
		local ++j
		
		
		
			clear
			mat C =  m`q'_15_1_2\m`q'_15_2_3\m`q'_15_3_4\m`q'_15_4_5\m`q'_15_5_6\m`q'_15_6_7\
			         m`q'_30_1_2\m`q'_30_2_3\m`q'_30_3_4\m`q'_30_4_5\m`q'_30_5_6\m`q'_30_6_7\
					 m`q'_60_1_2\m`q'_60_2_3\m`q'_60_3_4\m`q'_60_4_5\m`q'_60_5_6\m`q'_60_6_7      // Vertical Concatenation (Appending) of matrices
			svmat C, names(col)
			drop if obs1 == .
			
			
			/*foreach g in 15 30 60  {	
		
		use speed_`g' echalan interval_`g' road hr_m1 dow using `speed`g'_1', clear
		append using `speed`g'_2'
		append using `speed`g'_3'
		append using `speed`g'_4'
		append using `speed`g'_5'
		append using `speed`g'_6'
		encode road, gen(road_encode)
        egen hour=rowtotal(hr_m* ), m
		gen sunday = (dow==0)
		gen      keeper=1 if inlist(road, "1_2", "2_3")
		replace  keeper=1 if road=="3_4" & echalan==0
		replace  keeper=1 if road=="4_5" & echalan==0
		replace  keeper=1 if road=="5_6" & echalan==0
		replace  keeper=1 if road=="6_7" & echalan==1
		88
		reg speed_`g' echalan i.road_encode i.interval_15 if keeper==1
		outreg2  using chk1,  keep(echalan i.road_encode) stats(coef pval) dec(3) label word dta append
		reg speed_`g' echalan sunday i.road_encode i.interval_15 if keeper==1
		outreg2  using chk1,  keep(echalan sunday i.road_encode) stats(coef pval) dec(3) label word dta append
		
		reg speed_`g' echalan i.road_encode i.interval_15 if keeper==1 & inrange(hour, 8, 17)
		outreg2  using chk2,  keep(echalan i.road_encode) stats(coef pval) dec(3) label word dta append
		reg speed_`g' echalan sunday i.road_encode i.interval_15 if keeper==1 & inrange(hour, 8, 17)
		outreg2  using chk2,  keep(echalan sunday i.road_encode) stats(coef pval) dec(3) label word dta append

        *reg speed_`g' echalan i.road_encode i.interval_`g'
		*outreg2  using chk1,  keep(echalan *road_encode*)  stats(coef pval) dec(3)  word dta append
		*est store rs`g'
		
		
		use time_`g' echalan interval_`g' road hr_m1 dow using `tt`g'_1_2', clear
		append using `tt`g'_2_3'
		encode road, gen(road_encode)
		egen hour=rowtotal(hr_m1 hr_m2), m
		reg time_`g' echalan i.road_encode i.interval_`g'
		outreg2  using chk1,  keep(echalan *road_encode*)  stats(coef pval) dec(3)  word dta append
		*est store rt`g'
		reg time_`g' echalan i.road_encode i.interval_`g'   if inrange(hour, 8, 17)
		outreg2  using chk2,  keep(echalan *road_encode*)  stats(coef pval) dec(3)  word dta append
		*est store  r2t`g'
		
		use violations_`g' echalan interval_`g' road hr_m1 using `vt`g'_1_2', clear
		append using `vt`g'_2_3'
		encode road, gen(road_encode)
		egen hour=rowtotal(hr_m1 hr_m2), m
		reg violations_`g' echalan i.road_encode i.interval_`g'
		outreg2  using chk1,  keep(echalan *road_encode*)  stats(coef pval) dec(3)  word dta append
		*est store rv`g'
		reg violations_`g' echalan i.road_encode i.interval_`g'   if inrange(hour, 8, 17)
		outreg2  using chk2,  keep(echalan *road_encode*)  stats(coef pval) dec(3)  word dta append
		*est store r2v`g'
		
		
		
		}*/
			

