*The DROP = and KEEP = options specify which variables in the
input data setare to be omitted or processed in the data step. ;

*The RENAME = option renames variables exactly the
same as the RENAME statement. However, since this is
a SET statement data set option, the RENAME operation
occurs before the variable is added to the Program Data
Vector. ;

*It is important, therefore, to DROP or KEEP
the original names and not the RENAMEd names.;

*FIRSTOBS = specifies the observation
number in a data set that is the starting observation for
the SET statement. OBS = specifies the observation
number that is the last observation in a data set to read.;


/*Test 1:*/

*is an impossibility and would result in a fatal error.;

DATA newdata ;
SET dsname ( firstobs = 100 obs = 50 ) ;
RUN ;

*will sequentially read observation numbers 50 through
100 from data set dsname.;
DATA newdata ;
SET dsname ( firstobs = 50 obs = 100 ) ;
RUN ;


/*Test 2:*/

LIBNAME testlib 'D:\Testlib';

DATA Test_1;
INPUT PTNO ACTEVENT AGE WEIGHT	SEX;
DATALINES;
101	1	50	60.88	1
101	2	50	60.95	1
102	1	31	56.9	1
102	2	31	57.04	1
103	1	17	40.08	2
103	2	17	40.1	2
104	1	18	38.45	1
104	2	18	38.75	1
104	3	18	40.01	2
105	1	56	80.9	2
;
RUN;


DATA Test_n;

 SET Test_1 (WHERE=(ptno=101)) END=f;
  IF(f) THEN PUT "YES";

RUN;


DATA Test_2;
INPUT PTNO ACTEVENT AGE WEIGHT	SEX;
DATALINES;
107	1	34	18	97	1
106	1	28	39	25	2
105	2	56	92	96	2
105	1	56	54	53	2
104	4	18	4	  6	  2
104	3	18	81	52	1
104	2	18	85	6	  1
104	1	18	95	29	1
103	3	17	27	68	2
103	2	17	97	22	2
103	1	17	68	41	2
102	3	31	55	28	1
102	2	31	47	84	1
102	1	30	63	59	1
101	3	50	58	37	1
101	2	50	72	50	1
101	1	50	93	92	1
100	1	90	58	29	2
;
RUN;


DATA testlib.test_2;
  SET testlib.Test_2;
   Height=INT(ranuni(1)*100);
   Weight=INT(ranuni(1)*100);
   
RUN;


DATA testlib.test_1;
  SET testlib.Test_1;
    Height=round(ranuni(1)*100,0.01);
    Weight=round(ranuni(1)*100,0.01);
RUN;


DATA testlib.test_6;
  
  IF(_N_= 1) THEN SET testlib.Test_1;

	SET testlib.Test_2;

RUN;


/*Test 3:*/

DATA testlib.test_6;
  
     SET testlib.Test_1;
	 SET testlib.Test_2;

RUN;


/*Test 4:*/

*Concatenate multiple data sets;
SET dsname_1 dsname_2 ... dsname_n ;

/*Test 5:*/

*Interleave Multiple SAS Data Sets;

SET dsname_1 dsname_2 ... dsname_n ;
 BY varlist ;



 /*Test 5:*/

 DATA newdata ;
 SET dsname_1
( keep = total rename = ( total=oldtot ) ) ;
 SET dsname_1 ( firstobs = 2 ) ;
 delta = total - oldtot ;
RUN ;

 /*Test 6:*/

DATA a;
  INPUT ID X Y;
  DATALINES;
1 12 11
2 15  .
;
RUN;


DATA b;
  INPUT ID X Z;
  DATALINES;
1  .   4
3 17   6
3 18   .
;
RUN;

DATA expo;
	SET a;
	SET b;
RUN;
