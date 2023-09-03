```do

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

        ssc install egenmore
	egen N = sieve( string_variable ), char(-.0123456789) // take out these character from string variable
	destring  N, replace

**************************************************
   
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
	
	* removes "a_" from all variables names
	
	* a_varname ---> varname
	
	renpfix a_ 
	
	***********************************************

```
