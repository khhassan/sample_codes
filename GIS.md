```do
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


```
