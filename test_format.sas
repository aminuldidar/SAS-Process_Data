/*Example: 1*/

PROC FORMAT lib=work;
  VALUE sexfmt
    1= 'Male'
    2= 'Female'
    ;

  VALUE racefmt
    1 = 'White'
    2 = 'Black'
    3 = 'Other'
    ;

  VALUE zzz
    1 = 'Dhaka'
    2 = 'Ctg'
    3 = 'Sylhet'
    ;
RUN;


DATA test;
  INPUT PTNO ACTEVENT AGE WEIGHT SEX;
  DATALINES;
101 1 50 60.88 1
101 2 51 60.95 1
102 1 31 56.90 1
102 2 32 57.04 1
103 1 17 40.08 2
103 2 18 40.10 2
104 1 19 38.45 1
104 2 20 38.75 1
104 3 21 40.01 2
105 1 56 80.90 2
; 
RUN;


DATA test_1;
  SET Test;
    sex1=PUT(sex,sexfmt.);
RUN;


DATA test;
 INPUT @1 x $5. @7 y $5. @13 z 1.;
DATALINES;
117.7 1.746 1
06.61 97239 2
97123 0.126 3
;
RUN; 



/*Example: 2*/

DATA a1;
  DO a=1 TO 200;
  OUTPUT;
  END;
RUN;
 
  *** Create FORMAT Again for new Treatment Numbering;
PROC SORT DATA=a1 OUT=a2(keep=a) NODUPKEY;
    BY a;
RUN;
 

 DATA a3 (DROP=a);
    SET a2;

    LENGTH label $200 fmtname $8. ;
 
    fmtname = "grf";
 
    type    = "N"; 
    start   = a;
    label   = compress("Study:" || put(a,8.));
 RUN;

 
 PROC SORT DATA=a3;
    BY fmtname start;
 RUN;
 
 PROC FORMAT lib=work CNTLIN= a3;
 QUIT;
 
 
 
 DATA a2;
   SET a1;
 
   FORMAT a grf.;
 RUN;

DATA test;
  DO i=1 TO 10;
  OUTPUT;
  END;
RUN;


  DATA test1;
    SET test;
 
      FORMAT i grf.;
  RUN;


 /*Example: 3*/

 PROC FORMAT lib=work;
 VALUE agefmt 
  0 - <20 = '< 20'
 20 - <40 = '20 to 39'
 40 - <60 = '40 to 59'
 60 - HIGH = '60+'
  ;
RUN;


DATA survey;
    INPUT ID Gender $ Age Salary $ Ques1 Ques2 Ques3 Ques4 Ques5 AgeGroup $;
DATALINES;

001 M 23 28000 1 2 1 2 3 20 to 39
002 F 55 76123 4 5 2 1 1 40 to 59
003 M 38 36500 2 2 2 2 1 20 to 39
004 F 67 12800 5 3 2 2 4 60+
005 M 22 23060 3 3 3 4 2 20 to 39
006 M 63 90000 2 3 5 4 3 60+
007 F 45 76100 5 3 4 3 3 40 to 59
;
RUN;


DATA survey1;
 SET survey;
 Age1 = put(Age,agefmt.);
RUN; 

/*Example: 4*/

PROC FORMAT lib=work;
  VALUE SEXF
    1= 'Male'
    2= 'Female'
	3= 'N/A'
    ;

  VALUE $TRTF
    'A' = 'Treat A'
    'B' = 'Treat B'
    'C' = 'Treat C'
    ;
RUN;

PROC CATALOG CAT=work.formats;
  DELETE sexf.format;
RUN;

PROC CATALOG CAT=work.formats;
  DELETE trtf.formatc;
RUN;
