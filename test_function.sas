/*Length() function does not count the trailing space to determine length.*/


/*PUT and INPUT function*/
DATA dt;
 var="30NOV2015"D;
 PUT var=;
 chr=PUT(var,DATE9.);
 num=INPUT(chr,DATE9.);
RUN;


/*SUBSTR function*/
DATA substring;
str="This is a text.";
substr1=SUBSTR(str,6,4);
substr2=SUBSTR(str,6);

RUN;



/*SUBSTRN function*/
DATA string_trancate;
str="This is a text.";
substr1=SUBSTRN(str,6,4);
substr2=SUBSTRN(str,6);

RUN;



DATA HOAGIE;
 STRING = 'ABCDEFGHIJ';
 LENGTH RESULT $5.;
 RESULT = SUBSTRN(STRING,2,5);
 SUB1 = SUBSTRN(STRING,-1,4);
 SUB2 = SUBSTRN(STRING,3,0);
 SUB3 = SUBSTRN(STRING,7,5);
 ln=LENGTH(SUB3);
 SUB4 = SUBSTRN(STRING,0,2);
 
 PUT "Original String =" @25 STRING /
 "SUBSTRN(STRING,2,5) =" @25 RESULT /
 "SUBSTRN(STRING,-1,4) =" @25 SUB1 /
 "SUBSTRN(STRING,3,0) =" @25 SUB2 /
 "SUBSTRN(STRING,7,5) =" @25 SUB3 /
 "SUBSTRN(STRING,0,2) =" @25 SUB4;
 
RUN; 


/*Concat function*/
DATA concat;
   str1="String1";
   str2="String2";
   conct1 = str1 || str2;
   conct2  = str1 !! str2;
   conct3  = str1  || ' num1' || str2;
   conct4  = str1  || ' num1' || str2 || ' num2';
RUN;


/*COMPBL & COMPRESS function*/

DATA compbl;
   str1="St   ring";
   str2=COMPBL(str1);
   str3=COMPRESS(str2);
RUN;


/*LEFT(),RIGHT() & TRIM()function*/

DATA compbl;
   str1="      String";
   bfleft=LENGTH(str1);
   str2=LEFT(str1);
   strcon=str2 || 'habijabi';
   strcon=TRIM(str2) || 'habijabi';


   afleft=LENGTH(str2);
   
   str3="String      ";
   bfright=LENGTH(str3);
   str4=RIGHT(str1);
   afright=LENGTH(str4);
/*   str3=COMPRESS(str2);*/
RUN;

/*Length() function does not count the trailing space to determine length.*/

/*TRIM() does not remove trailing spaces*/

DATA compbl;
   str1="      String      ";
   strcon=TRIM(str1) || 'habijabi';

RUN;


/*TRANWRD() function*/
DATA Tarn_word;
   str1="This is a String.";
   str2=TRANWRD(str1,'is','are');

RUN;


/*SCAN() function*/
DATA scan;
   str1="This is a String.";
  
   str2=SCAN(str1,2,' ');  /*n-th part of the string(here 2nd)*/

   str3="This,is,a,String.";
  
   str4=SCAN(str3,3,',');

RUN;


/*INDEX() function*/
DATA indx;
   str1="This is a String.";
  
   str2=INDEX(str1,'a');  /*starting position of the given text of 2nd parameter*/

   str3="This,kjsakjcb,is,a,String.";
    var='is';
   str4=INDEX(str3,var);

RUN;


  ******************************************************************;
  ***                                                            ***;
  *** NUMERIC FUNCTIONS: ROUND, MOD, INT, ABS, CEIL and FLOOR    ***;
  ***                                                            ***;
  ******************************************************************;

DATA numeric;
  DO counter=-5, -2, -1.2345, -1, 1, 1.2345, 2, 5;

    rnd1=ROUND(counter,0.1);   * round to 1 d.p.;  
    rnd2=ROUND(counter,0.01);  * round to 2 d.p.;
    rnd3=ROUND(counter,0.001); * round to 3 d.p.;
    modval2=MOD(counter,2);    * remainder when all multiples of 2 are subtracted;
    modval3=MOD(counter,3);    * remainder when all multiples of 3 are subtracted;
    intval=INT(counter);       * Integer part of a number;
    absval=ABS(counter);       * Absolute value, i.e. without minus (-) sign;
    ceilval=CEIL(counter);     * Next highest integer ;
    floorval=FLOOR(counter);   * Next lowest integer ;
    OUTPUT;
  END;
RUN;


/*HMS(), DHMS(), YEAR(), DATEPART(), MONTH(), INTCK()*/
DATA datetime;
  FORMAT hrform TIME.;
  hrid=HMS(12,45,10);
  hrform=hrid;
 
  /*DATEPART()*/
  FORMAT dtidf DATETIME.;
  dtid=DHMS('01JAN03'D,15,30,15);
  dtidf= dtid;
  PUT dtidf=;
  mn=8; dy=27; yr=12;
  birthday= MDY(mn,dy,yr);
  put birthday DATE9.;

  dp=PUT(DATEPART(dtid),DATE9.);
  TP=PUT(TIMEPART(dtid),TIME.);
  year=YEAR('01JAN2013'D);
  month=MONTH('01JAN03'D);

  FORMAT dtidf DATETIME.;
  FORMAT dtidf1 DATETIME.;
  dtid=DHMS('01JAN03'D,15,30,15);
  dtidf= dtid;
  dtid=DHMS('01JAN03'D,20,40,15);
  dtidf1= dtid;
  mnthnum1=INTCK('DTDAY', dtidf,dtidf1);
  PUT mnthnum1=;
  mnthnum1=INTCK('HOUR', dtidf,dtidf1);
  PUT mnthnum1=;
  mnthnum1=INTCK('MINUTE', dtidf,dtidf1);
  PUT mnthnum1=;
  mnthnum1=INTCK('SECOND', dtidf,dtidf1);
  PUT mnthnum1=;
 
RUN;

/*Add hour or day*/
DATA NEWDTTM;
FORMAT DTTM2H DTTM3D DATETIME.;
  ADDDTTM=DHMS('12JAN2003'D,9,0,0);
  DTTM2H=ADDDTTM+2*60*60;
  PUT DTTM2H=;
  DTTM3D=ADDDTTM+3*24*60*60;
  PUT DTTM3D=;

RUN;
