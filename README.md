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
		
```


![image](https://user-images.githubusercontent.com/48903494/210287656-7fd29f5a-1afc-44f4-81d8-692e34f31319.png)
