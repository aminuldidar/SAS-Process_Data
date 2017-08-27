DATA dummy1;
  DO ptno=1 TO 20;
    DO visit=1 TO 4;
      bmi+3;
      presuure+0.6;
      IF mod(ptno,2)=0 THEN sex=repeat ('',8) || "Female";
      ELSE sex="Male";
      OUTPUT;
    END;
  END;
RUN;


DATA dummy;
  SET dummy1;

  IF ptno=2 and visit in (2 3 4) THEN CALL missing(presuure);
  ELSE IF ptno=14 and visit in (3 4) THEN CALL missing(bmi);

  IF sex="Male" THEN sexn=1;
  ELSE sexn=2;
RUN;


PROC SORT DATA=dummy;
  BY sex;
RUN;

OPTION pagesize=133 linesize=100;
ODS LISTING FILE="G:\PROC_REPORT\test1test1.lst" ;
ODS LISTING FILE="D:\PROC_REPORT\test2.TXT" ;
ODS RTF FILE="D:\PROC_REPORT\test3.DOC" ;



TITLE1 "Look Ttile1";
TITLE2 "Look Ttile2";

FOOTNOTE1 "Look Footnote1";
FOOTNOTE2 "Look Footnote2";


PROC REPORT DATA=dummy HEADLINE HEADSKIP SPACING=3 SPLIT='!';
  column ('-REPORT OF DUMMY DATA-' sex ptno visit ('_Test Lab_' bmi presuure ) bmi1);

  define sex  / order order=internal width=20; 
  define ptno  /order order=internal width=12; 
  define visit /order order=internal width=12;

  define presuure /  width=20 left "Systolic!Presure" flow;
  define bmi /       width=20 left "Body Mess Index" flow display;
  define bmi1      /  width=20  computed "Systolic Presure-Modified";

  compute bmi1;
    bmi1=bmi / 1000;
  endcomp;

  compute after ptno;
    line @10 "Visit Finished: ";
  endcomp;
run;

TITLE1;
TITLE2;
FOOTNOTE1;
FOOTNOTE2;
ODS LISTING;

*flow use for show all text;
*when variable use to derive another variable then it is needed to use

flow display;

DATA test;
  a1=3.245;
  OUTPUT;
  a1=10;
  OUTPUT;
  a1=10.45;
  OUTPUT;
  a1=200.3;
  OUTPUT;
RUN;


DATA chk;
  SET test;
  a1c=compress(put(a1,best.));
  indxbefore=index(a1c,'.');

  indxafter=length(a1c)-indxbefore;

  IF(indxbefore=0) THEN DO; 
                          indxbefore=indxafter; indxafter=0; 
                        END;
  ELSE indxbefore=indxbefore-1;

  IF index(a1c,'.') eq 0 THEN flg=2;
  ELSE flg=1;

  IF flg=1 THEN a1cx=put(a1,7.3);
  ELSE IF flg=2 THEN a1cx=put(a1,3.);
RUN;

PROC PRINT DATA=chk;
RUN;


PROC REPORT DATA=chk HEADSKIP SPACING=3;
  COLUMN a1cx;
RUN;


DATA dummy2;
  DO ptno=1 TO 20;
    DO visit=1 TO 4;
      bmi+3;
      presuure+0.6;
      IF mod(ptno,2)=0 THEN sex="Femaleare-bad";
      ELSE sex="Maleare-good";
      OUTPUT;
    END;
  END;
RUN;


OPTION pagesize=133 linesize=100;

PROC REPORT DATA=dummy2 HEADLINE HEADSKIP SPACING=3 SPLIT='-';
  COLUMN ('--' sex ptno visit ('_Test Lab_' bmi presuure ) bmi1);

  DEFINE sex  / order ORDER=internal WIDTH=20 FLOW LEFT; 
  DEFINE ptno  /order ORDER=internal WIDTH=50 LEFT; 
  DEFINE visit /order ORDER=internal WIDTH=12 RIGHT;

  DEFINE presuure /  WIDTH=20 LEFT "Systolic!Presure" FLOW;
  DEFINE bmi /       WIDTH=20 LEFT "Body Mess Index" FLOW DISPLAY;
  DEFINE bmi1     /  WIDTH=20 COMPUTED "Systolic Presure-Modified";

  COMPUTE bmi1;
    bmi1=bmi / 1000;
  ENDCOMP;

  COMPUTE AFTER ptno;
    LINE @10 "Visit Finished: ";
  ENDCOMP;
RUN;


/*
LS=line-size

    specifies the length of a line of the report.

    PROC REPORT honors the line size specifications that it finds in the following order of precedence:

        the LS= option in the PROC REPORT statement or LINESIZE= in the ROPTIONS window

        the LS= setting stored in the report definition loaded with REPORT= in the PROC REPORT statement

        the SAS system option LINESIZE=.

    Note:   The PROC REPORT LS= option takes precedence over all other line size options.  [cautionend]
    Range: 	64-256 (integer)
    Restriction: 	This option has no effect on ODS destinations other than traditional SAS monospace output.
    Featured in: 	Displaying Multiple Statistics for One Variable and Condensing a Report into Multiple Panels

PS=page-size

    specifies the number of lines in a page of the report.

    PROC REPORT honors the first of these page size specifications that it finds:

        the PS= option in the PROC REPORT statement

        the PS= setting in the report definition specified with REPORT= in the PROC REPORT statement

        the SAS system option PAGESIZE=.

    Range: 	15-32,767 (integer)
    Restriction: 	This option has no effect on ODS destinations other than traditional SAS monospace output.
    Featured in: 	Displaying Multiple Statistics for One Variable and Condensing a Report into Multiple Panels
*/
