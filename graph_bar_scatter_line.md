```do

* Data sample for graph
	
	input one_var	group_month_year  growth_cam_vio
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
  end
	
	
	twoway ( bar one_var group_month_year if inrange(group_month_year,4,25), yaxis(2)  ylabel(#3, axis(2)) ytitle(Number, axis(2)) xtitle(month)  fintensity(inten30)  ) ///
	        ( scatter growth_cam_vio group_month_year if inrange(group_month_year,4,25),  connect(l) yaxis(1) ytitle(Percent, axis(1)) ) ///
               ( lfit growth_cam_vio group_month_year if inrange(group_month_year,4,25)) ///
               , legend( order(1 "# violations" 2 "Growth rate" 3 "Fitted growth line")) ///
		 title("Camera violations per month w.r.t time" "$v")    ///
		 note("Note: Violations identified by PSCA camera") ///
		plotregion(fcolor(white))  graphregion(fcolor(white) style(none) color(gs16)) ylab(,nogrid)

```

<br>
<br>

![graph1](https://github.com/khhassan/sample_codes/assets/48903494/12a572d6-c1b1-433e-a9ee-dfccb48dbec2)




