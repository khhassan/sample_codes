# sample_codes

I have uploaded some Stata codes 

```do
gen = c

global address    = "D:\MALL_ROAD_2018"
		global regsave_12 = "D:\MALL_ROAD_2018\regressions\regsave_12_interact"
	
	   	cd "$regsave_12"
		
		use IV_data.dta , clear
	
		global xvar   "EW covid_day covid_day#road_numeric" // interaction terms added, covid_day excluded
		global xvar2  "EW covid_day covid_day##i.road_numeric" // interaction terms added, covid_day excluded
		
		cd "$regsave_12"
		
       foreach w in  interval_15 {  // time intervals : hour interval_30 interval_15
	 
		 if "`w'" == "hour" {
		 local c2 = "60-min interval"
		 local r = "6, 23"
		 }
		 if "`w'" == "interval_30" {
		 local c2 = "30-min interval"
		 local r = "13, 48"
		 }
		 if "`w'" == "interval_15" {
		 local c2 = "15-min interval"
		 local r = "25, 96"
		 }
			
		 regress density $xvar   i.`w'                                                /// time interval FE
		         if `w' !=. & inrange(`w', `r'), vce(cluster time_direct_`w' )	 
		 local fstat = e(F)
		 regsave using rt_`w' , table(reg1, format(%5.2f) parentheses(stderr) asterisk(10 5 1) ) addvar(fstat, `fstat' ) replace

```



![image](https://user-images.githubusercontent.com/48903494/210287656-7fd29f5a-1afc-44f4-81d8-692e34f31319.png)
