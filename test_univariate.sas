/*Example: 1*/
DATA Belts;
LABEL Strength = 'Breaking Strength (lb/in)'
      Width    = 'Width in Inches';
INPUT Strength Width @@;
DATALINES;
1243.51  3.036  1221.95  2.995  1131.67  2.983  1129.70  3.019
1198.08  3.106  1273.31  2.947  1250.24  3.018  1225.47  2.980
1126.78  2.965  1174.62  3.033  1250.79  2.941  1216.75  3.037
1285.30  2.893  1214.14  3.035  1270.24  2.957  1249.55  2.958
1166.02  3.067  1278.85  3.037  1280.74  2.984  1201.96  3.002
1101.73  2.961  1165.79  3.075  1186.19  3.058  1124.46  2.929
1213.62  2.984  1213.93  3.029  1289.59  2.956  1208.27  3.029
1247.48  3.027  1284.34  3.073  1209.09  3.004  1146.78  3.061
1224.03  2.915  1200.43  2.974  1183.42  3.033  1195.66  2.995
1258.31  2.958  1136.05  3.022  1177.44  3.090  1246.13  3.022
1183.67  3.045  1206.50  3.024  1195.69  3.005  1223.49  2.971
1147.47  2.944  1171.76  3.005  1207.28  3.065  1131.33  2.984
1215.92  3.003  1202.17  3.058
;
RUN;


PROC UNIVARIATE DATA=Belts NOPRINT;
   VAR Strength Width;
   OUTPUT OUT=Means         MEAN=StrengthMean WidthMean;
   OUTPUT OUT=StrengthStats MEAN=StrengthMean STD=StrengthSD 
                            MIN=StrengthMin   MAX=StrengthMax;
RUN;


/*
This example, which uses the Belts data set from the previous example, 
illustrates how to save percentiles in an output data set. The UNIVARIATE 
procedure automatically computes the 1st, 5th, 10th, 25th, 75th, 90th, 95th, 
and 99th percentiles for each variable. You can save these percentiles in an 
output data set by specifying the appropriate keywords. For example, the 
following statements create an output data set named PctlStrength, which 
contains the 5th and 95th percentiles of the variable Strength
*/

PROC UNIVARIATE DATA=Belts NOPRINT;
   VAR Strength;
   OUTPUT OUT=PctlStrength P5=p5str P95=p95str;
RUN;


/*
PROC SQL;
  SELECT * FROM Belts WHERE Strength=1126.78;
RUN;
*/

PROC UNIVARIATE DATA=Belts NOPRINT;
   VAR Strength Width;
   OUTPUT OUT=Pctls PCTLPTS  = 20 40
                    PCTLPRE  = Strength Width
                    PCTLNAME = pct20 pct40;
RUN;


/*Example: 2*/

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

        IF 11 LT ptno LT 30 THEN DO;
          age=400;
          htcm=250;
          wtkg=0.0023;
        END;
 
  	IF tpatt NE '' THEN tpattdc='Treatment '||tpatt;
  	ELSE tpattdc='Not randomised';
    OUTPUT;
  END;

  LABEL study   = Study number
        ptno    = Patient number
    		tpatt   = Treatment group - code
    		tpattdc = Treatment group - decode
    		sex     = Sex
    		age     = Age (years)
    		htcm    = Height (cm)
    		wtkg    = Weight (kg)
    		;
RUN;


/*
1. Create New Data Set: DATA2USE1 ;using aforementioned DATASET: DUMMY, where
   Summarized Values (N=, MIN=, MAX=, MEDIAN, Coefficient of Variance,
   Quantile 1 and 3)
   for Variables: AGE, HTCM, and WTKG per sex group per Treatment Group. 
   TIPS: Use PROC UNIVARIATE Procedures.
*/


PROC SORT DATA=Dummy;
  BY tpatt sex;
RUN; 


PROC UNIVARIATE DATA=Dummy NOPRINT;
  BY tpatt sex;
  VAR AGE HTCM WTKG;
  OUTPUT OUT=DATA2USE1 N=n1 n2 n3
  					   MIN=AgeMin HtcmMin WtkgMin  
                       MAX=AgeMax HtcmMax WtkgMax
                       MEAN=AgeMean HtcmMean WtkgMean
					   CV=AgeCv HtcmCv WtkgCv
					   Q1=AgeQ1 HtcmQ1 WtkgQ1
					   Q3=AgeQ3 HtcmQ3 WtkgQ3;
RUN;
