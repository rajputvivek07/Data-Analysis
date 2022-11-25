data first;
	set sashelp.baseball;
run;
title 5 point Summary;
	proc means data=sashelp.baseball mean median mode std var min max;
run;

Title NUmber of missing values;
	proc means data=sashelp.baseball nmiss;
run;

title Getting Number of Distinct Values;
proc sql;
select count(distinct Name) as Name,
       count(distinct Team) as Team,
       count(distinct nAtBat) as nAtBat,
       count(distinct nHits) as nHits,
       count(distinct nHome) as nHome
  from sashelp.baseball;
quit;

title Correlation of the Attributes;
proc corr data=sashelp.baseball;
run;

title Frequency of the Categorical Values
proc freq data=Sashelp.baseball; 
   tables_CHARACTER_;    /* _ALL_ is the defaul */
run;

ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot data=sashelp.baseball;
	vbox  nRuns / category= Team;
	yaxis grid;
run;
ods graphics / reset;

title "Scatter Plot of nOuts and nAssts";
proc sgplot data=sashelp.baseball;
    scatter x = nOuts  y = nAssts ;
run;


title "Salary Outlier";
proc sgplot data=sashelp.baseball;
	vbox  Salary / category=Team;
	yaxis grid;
run;
ods graphics / reset;

title "logSalary Outlier";
proc sgplot data=sashelp.baseball;
	vbox  logSalary / category=Team;
	yaxis grid;
run;
ods graphics / reset;


title "nBB ";
proc sgplot data=sashelp.baseball;
	vbox  nBB / category=CrBB;
	yaxis grid;
run;

title  CrRBi Histogram grouped by League;
ods graphics / reset;
proc sort data=SASHELP.Baseball out=_HistogramTaskData;
	by League;
run;
proc sgplot data=_HistogramTaskData;
	by League;
	histogram CrRBi /;
	yaxis grid;
run;
proc sgplot data=_HistogramTaskData;
	by League;
	histogram nRBi /;
	yaxis grid;
run;
