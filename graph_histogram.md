```do
* Data sample for graph
	
	input 	var1  var2
	13  	        9
	13		7
	12		1
	12		2
	12		3
	1		1
	1		3
	1		5
	1		5
	2		9
	2		1
	5	        1
	5		1
	5		9
	5		1
	5		6
	4		3
	1		1
	1		6
	7		4
	6	        1
	5		1
	9		6
	1		1
	2		7
	4		9
	1		3
	1		2
  end
  
	  * histogram with overlapped bars = green over transparent
	  
	  twoway (histogram var1 , freq start(0) width(1) color(green)) ///
                (histogram var2 , freq start(0) width(1) fcolor(none) lcolor(black)), ///
                 xline(5) ///
                 legend(order(1 "1992" 2 "2013" )) xtitle("DN values") ///
		title("Camera violations per month w.r.t time" "$v")    ///
		note("Note: Violations identified by PSCA camera") ///
		plotregion(fcolor(white))  graphregion(fcolor(white) style(none) color(gs16)) ylab(,nogrid) 
	 graph export "C:\Users\hassa\Dropbox (Personal)\Satellite Imagery KP Pak Project\Data\Outputs\Histogram_pesh.png", replace width(3000) height(2200)

```

<br>

![graph2](https://github.com/khhassan/sample_codes/assets/48903494/f52a57a3-a227-4b97-afd1-9486810ea5ab)

