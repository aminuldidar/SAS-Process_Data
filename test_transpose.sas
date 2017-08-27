****************************************************;
* Create file1 input file                           ;
****************************************************;
DATA work.test1;
INFILE cards;
LENGTH pet_owner $10 pet $4 population 4;
INPUT pet_owner $1-10 pet $ population;
CARDS;
Mr. Black dog 2
Mr. Black bird 1
Mrs. Green fish 5
Mr. White cat 3
;
RUN;


****************************************************;
* Create file2 input file                           ;
****************************************************;
DATA work.test2;
INFILE cards;
LENGTH pet_owner $10 pet $4 population 4;
INPUT pet_owner $1-10 pet $ population;
CARDS;
Mr. Black dog 2
Mr. Black cat 1
Mrs. Brown dog 1
Mrs. Brown cat 0
Mrs. Green fish 5
Mr. White fish 7
Mr. White dog 1
Mr. White cat 3
;
RUN;


****************************************************;
* Create file3 input file                           ;
****************************************************;
DATA work.test3;
INFILE cards MISSOVER;
LENGTH pet_owner $10 cat 4 dog 4 fish 4 bird 4;
INPUT pet_owner $1-10 cat dog fish bird;
CARDS;
Mr. Black 1 2 . 0
Mrs. Brown 0 1 0 1
Mrs. Green . 0 5
Mr. White 3 1 7 2
;
RUN;



/*A) Simple transpose*/

/*Note: unless you tell it otherwise, only numeric variables are transposed.
Go back and look at the input file – the other, non-numeric, variables, 
including pet_owner and pet, are ignored. The input file could just as 
easily have contained only 1 column, “population”.*/

PROC TRANSPOSE DATA=work.test1 OUT=work.test4;

RUN;


DATA test5;
   SET test1;
    ver=INT(RANUNI(1)*100);
RUN;


PROC TRANSPOSE DATA=work.test5 
  OUT=work.test6;
RUN;


/*B) PREFIX option*/

PROC TRANSPOSE DATA=work.test1
   OUT=work.test7
   PREFIX=pet_count;
RUN;


PROC TRANSPOSE DATA=work.test5
  OUT=work.test8
  PREFIX=pet_count;
RUN;



/*C) NAME option*/

PROC TRANSPOSE DATA=work.test1
  OUT=work.test8
  NAME=column_that_was_transposed
  PREFIX=pet_count;
RUN;

PROC TRANSPOSE DATA=work.test5
  OUT=work.test9
  NAME=column_that_was_transposed
  PREFIX=pet_count;
RUN;


/*D) ID statement*/
PROC TRANSPOSE DATA=work.test1 OUT=work.test10 NAME=column_that_was_transposed;
/* After OUT all are options */
  ID pet;
RUN;


/*E) VAR statement*/
PROC TRANSPOSE DATA=work.test1 OUT=work.test11;
  VAR pet population;
RUN;


PROC TRANSPOSE DATA=work.test1 OUT=work.test12;
  ID pet;
  VAR population;
RUN;


/*F) VAR and ID statements*/
PROC TRANSPOSE DATA=work.test1
  OUT=work.test13
  NAME=column_that_was_transposed;
  VAR pet population;
  ID pet;
RUN;


/*G) Simple transpose*/
PROC TRANSPOSE DATA=work.test2
  OUT=work.test14;
RUN;



/*H) VAR statement*/
PROC TRANSPOSE DATA=work.test2
  OUT=work.test15
  NAME=column_that_was_transposed;
  VAR pet population;
RUN;


/*I) BY statement*/
PROC SORT DATA=work.test2
  OUT= work.test2;
  BY pet_owner;
RUN;

PROC TRANSPOSE DATA=work.test2
  OUT=work.test16
  NAME=column_that_was_transposed;
  BY pet_owner;
RUN;


/*J) BY and ID statements*/
PROC TRANSPOSE DATA=work.test2
  OUT=work.test16
  NAME=column_that_was_transposed;
  BY pet_owner;
  ID pet;
RUN;


/*K) Simple transpose*/
PROC TRANSPOSE DATA=work.test3
  OUT=work.test17;
RUN;


/*L) NAME and PREFIX options*/
PROC TRANSPOSE DATA=work.test3
  OUT=work.test18
  NAME=column_that_was_transposed
  PREFIX=pet_count;
RUN;


/*M) ID statement*/
PROC TRANSPOSE DATA=work.test3
  OUT=work.test19
  NAME=column_that_was_transposed;
  ID pet_owner;
RUN;


/*Another Example*/
DATA dummy;
  LENGTH study $5. tpatt $5. tpattdc $15. sex $6.;
  study='DUMMY';

  DO ptno=1 TO 100;
      tpatt =SUBSTR('ABC',MOD(INT(RANUNI(0)*100),3)+1,1);
	    sex   =SCAN('MALE FEMALE',MOD(INT(RANUNI(0)*100),2)+1);
	    age   =ROUND(RANUNI(0)*100,0.001);
  	  htcm  =ROUND(RANUNI(0)*200,0.001);
  	  wtkg  =ROUND(RANUNI(0)*100,0.001);

  	  IF ptno=10 THEN tpatt='';
  	  ELSE IF ptno=20 THEN sex='';
  	  ELSE IF ptno=30 THEN age=.;
  	  IF tpatt NE '' THEN tpattdc='Treatment '||tpatt;
  	  ELSE tpattdc='Not randomised';
      OUTPUT;
  END;

  LABEL     study   = Study number
            ptno    = Patient number
    		tpatt   = Treatment group - code
    		tpattdc = Treatment group - decode
    		sex     = Sex
    		age     = Age (years)
    		htcm    = Height (cm)
    		wtkg    = Weight (kg)
    		;
RUN;


PROC SORT DATA=dummy OUT=dummy1;
  BY sex ptno tpatt;
RUN;


/*ID should be unique for each BY group*/

PROC TRANSPOSE DATA=dummy1 OUT=test1;
  BY sex ptno;
  ID tpatt;
  VAR age htcm;
RUN;


PROC TRANSPOSE DATA=test1 OUT=test2;
  BY sex ptno;
  VAR C A B;
RUN;
