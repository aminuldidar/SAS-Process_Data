PROC FREQ;
RUN;


TITLE "ORIGIN FREQ - ONE WAY";
PROC FREQ DATA=sashelp.cars;
	TABLE origin;
RUN;


TITLE "ORIGIN AND DRIVETRAIN FREQ - ONE WAY";
PROC FREQ DATA=sashelp.cars;
	TABLE origin drivetrain;
RUN;


TITLE "ORIGIN AND DRIVETRAIN FREQ - N WAY";
PROC FREQ DATA=sashelp.cars;
	TABLE origin*drivetrain / NOCOL NOROW NOPERCENT;
RUN;


TITLE "ORIGIN AND DRIVETRAIN FREQ - N WAY / OPTION LIST";
PROC FREQ DATA=sashelp.cars;
	TABLE origin*drivetrain / LIST;
RUN;


TITLE "ORIGIN AND DRIVETRAIN FREQ - N WAY / OPTION NOCOL";
PROC FREQ DATA=sashelp.cars;
	TABLE origin*drivetrain /  NOCOL;
RUN;


TITLE "ORIGIN AND DRIVETRAIN FREQ - N WAY / OPTION NOROW";
PROC FREQ DATA=sashelp.cars;
	TABLE origin*drivetrain /  NOROW;
RUN;


TITLE "ORIGIN AND DRIVETRAIN FREQ - N WAY / OPTION NOPERCENT";
PROC FREQ DATA=sashelp.cars;
	TABLE origin*drivetrain /  NOPERCENT;
RUN;


TITLE "ORIGIN AND DRIVETRAIN FREQ - N WAY / OPTION CROSSLIST";
PROC FREQ DATA=sashelp.cars;
	TABLE origin*drivetrain / OUT=a1 CROSSLIST;
RUN;


PROC SORT DATA=sashelp.cars OUT=cars;
	BY type;
RUN;


TITLE "ORIGIN AND DRIVETRAIN FREQ - N WAY / OPTION CROSSLIST";
PROC FREQ DATA=cars NOPRINT;
    BY type;
	TABLE origin*drivetrain / OUT=a ;
RUN;


DATA one;
   INPUT A Freq;
   DATALINES;
1 2
2 2
. 3
2 5
;


PROC FREQ DATA=one;
   TABLES A / OUT=a;
   WEIGHT Freq;
   TITLE 'Default';
RUN;


PROC FREQ DATA=one;
   TABLES A /OUT=a MISSPRINT;
   WEIGHT Freq;
   TITLE 'MISSPRINT Option';
RUN;


PROC FREQ DATA=one;
   TABLES A / out=a MISSING;
   WEIGHT Freq;
   TITLE 'MISSING Option';
RUN;


DATA Color;
  INPUT Region Eyes $ Hair $ Count @@;
  LABEL Eyes  ='Eye Color'
        Hair  ='Hair Color'
        Region='Geographic Region';
  DATALINES;
1 blue  fair   23  1 blue  red     7  1 blue  medium 24
1 blue  dark   11  1 green fair   19  1 green red     7
1 green medium 18  1 green dark   14  1 brown fair   34
1 brown red     5  1 brown medium 41  1 brown dark   40 
1 brown black   3  2 blue  fair   46  2 blue  red    21
2 blue  medium 44  2 blue  dark   40  2 blue  black   6
2 green fair   50  2 green red    31  2 green medium 37
2 green dark   23  2 brown fair   56  2 brown red    42
2 brown medium 53  2 brown dark   54  2 brown black  13
;


PROC FREQ DATA=Color;
   TABLES Eyes Hair Eyes*Hair / OUT=FreqCount OUTEXPECT SPARSE;
   WEIGHT Count;
   TITLE 'Eye and Hair Color of European Children';
RUN;

/*
PROC SQL;
  SELECT SUM(Count) FROM Color WHERE Eyes='blue';

RUN;

PROC SQL;
  SELECT SUM(Count) FROM Color WHERE Eyes='blue' AND Hair='black';

RUN;
*/

PROC PRINT DATA=FreqCount NOOBS;
   TITLE2 'Output Data Set from PROC FREQ';
RUN;


DATA Demo;
   INPUT grp $ subgrp;
   DATALINES;
A 2
B 2
A 1
A 1
B 1
;

DATA Demo;
   INPUT grp $ subgrp;
   DATALINES;
A 2
B 2
A 1
A 1
;

PROC FREQ DATA=Demo;
   TABLES grp*subgrp / out=FrCount OUTEXPECT;
   TITLE 'Eye and Hair Color of European Children';
RUN;

/*
Although producing frequency tables on variables with numerous values is 
not often very valuable, there are times that it is necessary to identify 
those values that occur most often. 
The frequency procedure provides options to simplify this process.
The order = option orders the values of the frequency and crosstabulation 
table variables according to the specified order, where:
data orders values according to their order in the input dataset
formatted orders values by their formatted values
freq orders values by descending frequency count
internal orders values by their unformatted values
For example, a SAS dataset of physician claims (physician04) for a year period has over 5 million observations. You are requested to identify the top 10 procedures in that period. To accomplish this, the order = freq option outputs the variables in descending count order
*/
DATA Demo;
   INPUT grp $ subgrp;
   DATALINES;
A 2
B 2
A 1
A 1
B 1
B 1
B 1
;

DATA Demo;
   INPUT grp $ subgrp;
   DATALINES;
B 1
A 2
B 2
A 1
A 1
B 1
B 1
;

PROC FREQ DATA = Demo ORDER = data;
  TABLES grp*subgrp/ OUT = proccount;
RUN; 


DATA pain ;
INPUT site group pain ;
LABEL site = ’Test Center’
 group = ’Procedure’
 pain = ’Pain Level’ ;
CARDS;
1 1 2
1 2 0
1 2 1
1 2 2
2 2 0
2 1 0
3 3 2
3 3 1
;
RUN;

PROC FREQ DATA=pain;
 TABLES pain;
RUN;

PROC FORMAT;
  VALUE pain 
  0='None' 
  1='Tolerable'
  2='Intolerable' 
  ;
RUN;

PROC FREQ DATA=pain; 
  TABLES pain;
  FORMAT pain pain.;
RUN;

PROC FREQ DATA=pain ORDER=data;  
  TABLES pain;
  FORMAT pain pain.;
RUN;

PROC FREQ DATA=pain ORDER=formatted;
  TABLES group;
  FORMAT pain pain.;
RUN;

PROC FREQ DATA=pain ORDER=formatted;
  TABLES pain / OUT=pct OUTCUM;
  FORMAT pain pain.;
RUN;

PROC FREQ DATA=pain ORDER=formatted;
  TABLES pain*group / OUT=pct OUTPCT;
  FORMAT pain pain.;
RUN;
