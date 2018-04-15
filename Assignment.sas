/* 1) Write a shorter query using SAS arrays to 
replace '0's as missing values in “Online Orders.csv” dataset.
 Use asterix(*). */

proc import datafile='Y:\Advance_SAS\Graded Assignment\Arrays\Data sets\Online Orders.csv'
out=Online_Orders
dbms=csv replace;
run; 

data replacemiss;
set Online_Orders;
array n_miss _numeric_;
do over n_miss;
if n_miss=0 then n_miss=.;
end;
run;



/*2)  a)	Change the values of (NA,?) to missing character 
values with SAS arrays. (Hint: Use IF THEN statement) 
b)	Detect and correct the erros in below codes. 
data char_m;set Orders;array char_var{} $ _character_;           
do t= 1 to dim(char_var);char_var{i} = lowcase(char_var{i}); end;run;   */ 


data replaceNA;
set Online_Orders;
array n_miss _character_;
do over n_miss;
if n_miss="NA" or n_miss="?" then n_miss=.;
end;
run;


data char_m;
set Online_Orders;
array char_var _character_;
do i=1 to dim(char_var);
char_var = lowcase(char_var{i});
end;
run;


/* 3) 3)	Use IF THEN statement to increment the 
values in "Scores.txt" data which are lesser than 65.
(Hint: Add a value to the points to increment the points to just above 65.)  */


proc import datafile ='Y:\Advance_SAS\Graded Assignment\Arrays\Data sets\scores.txt'
out=scores
dbms=tab replace;
run;

data increment;
set scores;
array inc(*) Test_1--Test_5;
do i=1 to dim(inc);
if inc(i)<65 then inc(i) = inc(i)+(65.6-inc(i));
end;
run;

proc print data=scores;
run;
proc print data=increment;
run;

/*
4)
The data set "Sales.csv" has details of number of
units sold across regions of four products.The target
sales across regions(North, East, West), of four products()
is given as (9450,9100,8550,9700). With the help of SAS arrays 
find, what was the percentage 
of targets achieved for each product-region pair. 
(Hint: Use temporary arrays.)  
*/


proc import datafile='Y:\Advance_SAS\Graded Assignment\Arrays\Data sets\Sales.csv'
out=Sales
dbms=csv replace;
run;

data max;
set sales;
array target{4} _temporary_ (9450,9100,8550,9700);
array Product{4} Product_1--Product_4;
N_Targets=0;
do i=1 to dim(target);
N_Targets + (target(i) ge Product(i));
end;
Percen_Reg=(N_Targetsachieved/4)*100;
Percen_ToTar=(N_Targetsachieved/6)*100;
run;




/* 5)
Consider the below table and the goal is to create four observations
for each original observation, one for each variable. (Hint: Store the 
four observations in an array, and loop over the array, creating a new 
observation each time.)
 
ID 	s1 	s2 	s3 	s4 
1 	12 	15 	20 	23 
2 	17 	21 	33 	13 
3 	19 	23 	39 	30 

*/


data table;
input ID s1$ s2$ s3$ s4$;
datalines;
1 	12 	15 	20 	23
2 	17 	21 	33 	13
3 	19 	23 	39 	30
;
run;

data nw_table;
set table;
array ss(4) s1--s4;
do i =1 to dim(ss);
new = ss(i);
output;
end;
drop s1--s4;
run;


/*
6)	The data set “Subset.csv” is extracted from “Online Orders.csv” Data set.
The task is to count the missing values across rows with the help of Two
dimensional array. 
(Hint: Use IF THEN statement with do loop). 
*/

proc import datafile="Y:\Advance_SAS\Graded Assignment\Arrays\Data sets\Subset.csv"
out= sset
dbms=csv replace;
run;

data mer;
set sset;
array Missing(2,3) Day5-Day7 City1-City3;
count=0;
do i=1 to 2;
do j=1 to 3;
if Missing(i,j)="NA" then count=count+1;
end;
end;
run;