/*Pro:1*/
PROC EXPORT DATA=sashelp.class
  OUTFILE="D:\data1\egov.txt"
  DBMS=dlm;
	DELIMITER=' ';
RUN;

PROC EXPORT DATA=sashelp.class
  OUTFILE="D:\data1\egov.txt"
  DBMS=' ' REPLACE;
/*	DELIMITER='';*/
RUN;

/*Pro:2*/
PROC EXPORT DATA=sashelp.class (where=(sex='F'))
     OUTFILE="D:\data1\Femalelist.xls"
     DBMS=xls 
     REPLACE;
RUN;

PROC EXPORT DATA=sashelp.class (where=(sex='F'))
     OUTFILE="D:\data1\Femalelist.csv"
     DBMS=csv 
     REPLACE;
RUN;


/*Pro:3*/

PROC PRINT DATA=sashelp.class;
RUN;

PROC EXPORT DATA=sashelp.class
     OUTFILE="D:\data1\invoice_names.txt"
     DBMS=TAB REPLACE;
     PUTNAMES=NO;
RUN;

PROC EXPORT DATA=sashelp.class
            OUTFILE= "D:\data1\invoice_names.XLS" 
            DBMS=XLS REPLACE;
     				NEWFILE=NO;
RUN;


PROC PRINT; 
RUN;

PROC EXPORT DATA=sashelp.class
     OUTFILE="D:\data1\invoice_data_1st.txt"
     DBMS=TAB REPLACE;
     PUTNAMES=NO;
RUN;

PROC PRINT; 
RUN;


/*Pro:4*/

OPTIONS NODATE PS=60 ls=80;

PROC IMPORT DATAFILE="D:\data1\delimiter.txt"
            DBMS=dlm
            OUT=mydata
            REPLACE;
            DELIMITER='26'x;
             
            GETNAMES=YES; /*YES*/
RUN;

PROC PRINT DATA=mydata;
RUN;

/*Pro:5*/

FILENAME stdata 'D:\data1\state_data.txt';

PROC IMPORT DATAFILE=stdata
     DBMS=dlm
     OUT=states REPLACE; 
     DELIMITER=','; 
		 GETNAMES=YES;
RUN;

DELIMITER=' ';

PROC PRINT DATA=states;
RUN;

/*Pro:6*/

proc import datafile='D:\data1\tab.txt'
            out=class
            dbms=dlm
            replace;

/*	          DATAROW=5;*/

            DELIMITER='09'x;
			
run;
proc print data=class;
run;

/*Pro:7*/

proc import datafile="D:\data1\test.csv"
        out=shoes
        dbms=csv
        replace;
        getnames=no;
run;

proc print data=work.shoes;
run;


/*Pro:8*/
PROC EXPORT DATA= Sashelp.Class 
            OUTFILE= "D:\data1\want.xlsx " 
            DBMS=xlsx REPLACE;
     sheet="Class";

PROC EXPORT DATA=sashelp.cars 
            OUTFILE="D:\data1\want.xlsx " 
            DBMS=xlsx;
     sheet="Car";
RUN;

/*Pro:9*/
/*
The default values are:
Table : 1
Byline : 0
Title : 1
Footer : 1
PageBreak : 1
*/

ods tagsets.excelxp file="spacing.xls" style=statistical
    options( skip_space='3,2,0,0,1' sheet_interval='none'
               suppress_bylines='no');

  proc sort data=sashelp.class out=class;
     by age;
  run;

  proc print data=class;
     by age;
  run;

ods tagsets.excelxp close;



LIBNAME js 'D:\data1';
FILENAME egov 'D:\data1\egov.txt';

DATA js.seoul;
   INFILE egov LRECL=250 FIRSTOBS=2 OBS=5;
   INPUT name $ sex $ Age Height Weight;
RUN;
