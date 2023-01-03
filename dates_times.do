

	clear all
	set more off
	mat drop _all
	
	
***********************************************

gen double      newdate = mdy( month_m , day_m , year_m )
		quietly replace newdate = dhms(newdate , hr_m  , min_m , sec_m )
		gen date_time = string( newdate ,"%tc")
		gen double event_m = clock( date_time ,"DMY hms")
		
		di td(01jan2020) // 21915
		di td(01nov2020) // 22220

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

