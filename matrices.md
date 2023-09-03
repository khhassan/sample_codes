```do

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

```
