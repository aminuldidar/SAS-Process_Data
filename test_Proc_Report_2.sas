/*====================================================================*
*                                                                     *
* STUDY               : xxxx.xx             CREATION DATE: 01OCT2003  *
*                                                                     *
* PROGRAM             : _PROC_REPORT.sas                              *
*                                                                     *
* PROGRAM LOCATION    : !clinrep\sxxxxxx\pgm                          *
*                                                                     *
* PROGRAMMER          : Shafi Chowdhury                               *
*                                                                     *
* DESCRIPTION         : Program to help understand how to use PROC    *
*                         REPORT to produce the desired table.        *
*                                                                     *
* SAS PLATFORM/VERSION: Windows XP / SAS V8.2 (UNIX / SAS V8.2)       *
*                                                                     *
* FILES USED          : [tempdata] formats, patd, phys, labdata       *
*                       [ads]                                         *
*                                                                     *
* FILES CREATED       : [ads]                                         *
*                                                                     *
* EXTERNAL PROGRAMS                                                   *
*   OR MACROS USED    :                                               *
*                                                                     *
* COMMENT             :                                               *
*                                                                     *
*---------------------------------------------------------------------*
*                                                                     *
* REVISION HISTORY (COPY FOR EACH REVISION):                          *
*                                                                     *
* DATE:                PROGRAMMER:                                    *
* DESCRIPTION:                                                        *
*                                                                     *
*====================================================================*/

%LET text='xx';
TITLE1 'Understanding Proc REPORT';

OPTIONS LINESIZE=120 NODATE NONUMBER;


  ******************************************************************;
  ******************************************************************;
  ******************************************************************;
  ********************                          ********************;
  ********************  GET ALL EXTERNAL DATA   ********************;
  ********************                          ********************;
  ******************************************************************;
  ******************************************************************;
  ******************************************************************;


  ******************************************************************;
  ***                                                            ***;
  *** Assign libname, get all formats, then get all the datasets.***;
  ***                                                            ***;
  ******************************************************************;

* Set up Libname and read in data *;

/*LIBNAME tempdata 'E:\My Folders\D drive\SAS Traing Program\Proc REPORT';*/

LIBNAME tempdata "\\server\Training_Internee\SAS_Training_Program\Proc REPORT\Proc REPORT";

PROC FORMAT CNTLIN=tempdata.formats;
RUN;

%MACRO getdata(dset=, byvars=);
  PROC SORT DATA=tempdata.&dset OUT=&dset;
    BY &byvars;
  RUN;

  TITLE3 "Raw data from the dataset &dset";
  PROC CONTENTS DATA=&dset;
  RUN;
  TITLE3;
%MEND getdata;

%getdata(dset=PATD,     byvars=ptno actevent);
%getdata(dset=PHYS,     byvars=ptno actevent);


  ******************************************************************;
  ***                                                            ***;
  ***                     PROC REPORT                            ***;
  ***                     ¯¯¯¯¯¯¯¯¯¯¯                            ***;
  ***  SYNTAX:                                                   ***;
  *** *A* PROC REPORT DATA= <options> ;                          ***;
  *** *B*   COLUMNS var1 var2 var3;                              ***;
  *** *C*   DEFINE var1...                                       ***;
  ***       DEFINE var2...                                       ***;
  ***       DEFINE var3...                                       ***;
  ***                                                            ***;
  *** *D*   BREAK AFTER BEFORE  var / SKIP PAGE                  ***;
  ***                                                            ***;
  *** *E*   COMPUTE AFTER;                                       ***;
  ***         LINE                                               ***;
  ***         LINE @                                             ***;
  ***       ENDCOMP;                                             ***;
  ***     RUN;                                                   ***;
  ******************************************************************;


  ******************************************************************;
  ***   ***A***                                                  ***;
  ***                                                            ***;
  ***  Explanation of options:                                   ***;
  ***                                                            ***;
  ***  NOWD - Sends output to output window. Without this option ***;
  ***         SAS opens a new window with the output.            ***;
  ***                                                            ***;
  ***  HEADLINE - Draws a line (as wide as the table) under the  ***;
  ***             column headers.                                ***;
  ***                                                            ***;
  ***  HEADSKIP - Skips a line between the headline and the start***;
  ***             of the data.                                   ***;
  ***                                                            ***;
  ***  MISSING - Prints missing values.                          ***;
  ***                                                            ***;
  ***  SPLIT=''- Splits a text at the character given here.      ***;
  ***            USE A CHARACTER THAT DOES NOT OFTEN APPEAR      ***;
  ***            ie. ~,\,§                                       ***;
  ***            If the character appears anywhere in any text   ***;
  ***            it will not be printed and the line will be     ***;
  ***            broken at that position.                        ***;
  ***                                                            ***;
  ***  SPACING= - Specifies the amount of space between columns. ***;
  ***                                                            ***;
  ***  BOX - Puts all data into cells. Similar to TABULATE.      ***;
  ***                                                            ***;
  ***  LS= - Specifies the line size.                            ***;
  ***                                                            ***;
  ***  PS= - Specifies the page length.                          ***;
  ******************************************************************;


  ******************************************************************;
  ***  ***B***                                                   ***;
  ***                                                            ***;
  ***  COLUMNS statement:                                        ***;
  ***   Variables will be printed in the order you type them     ***;
  ***   in this line.  Does not depend on order of DEFINE        ***;
  ***   statements                                               ***;
  ******************************************************************;


  ******************************************************************;
  ***  ***C***                                                   ***;
  ***  DEFINE Statement with options:                            ***;
  ***    Specifies attributes of the variable being defined.     ***;
  ***    ORDER - Makes the variable an order variable            ***;
  ***    DISPLAY - Default value.                                ***;
  ***    ORDER= - Sets how the variable should be ordered        ***;
  ***           - FORMATTED (default) orders based on formatted  ***;
  ***              values                                        ***;
  ***           - DATA keeps the variable as in the incoming     ***;
  ***              dataset.                                      ***;
  ***           - INTERNAL sorts the variable ascending order.   ***;
  ***    WIDTH= - Sets the width of the column.                  ***;
  ***    FLOW - Wraps data if width of column is too small.      ***;
  ***           SHOULD ALWAYS BE USED WITH A WIDTH STATEMENT     ***;
  ***    FORMAT= - Attaches a format to the variable             ***;
  ***    LEFT/RIGHT/CENTER - Defines the position of values in   ***;
  ***                        the column.                         ***;
  ***                                                            ***;
  ***                                                            ***;
  ******************************************************************;


  ******************************************************************;
  ******************************************************************;
  ******************************************************************;
  ********************                          ********************;
  ******************** UNDERSTANDING THE BASICS ********************;
  ********************                          ********************;
  ******************************************************************;
  ******************************************************************;
  ******************************************************************;


  ******************************************************************;
  ***                                                            ***;
  *** PROC REPORT prints a dataset to the OUTPUT location.       ***;
  ***                                                            ***;
  *** Proc report can derive summaries, create new variables,    ***;
  ***   and do many more tasks. However, for our purpose, it is  ***;
  ***   to only use it for printing.                             ***;
  *** It is easier to derive variables in DATA steps, and in most***;
  ***   cases there will be datasets before the proc report.     ***;
  ***                                                            ***;
  *** Do all manipulations before and use PROC REPORT only for   ***;
  ***   printing!                                                ***;
  ***                                                            ***;
  ******************************************************************;

* To print PATD data: ;

* This opens a REPORT window to print the data, but usually we just want it in the 
*   OUTPUT window.
;

PROC REPORT DATA=patd;
  COLUMN ptno actevent visdt bthdt sex;
RUN;


* NOWD or NOWINDOWS will ensure a REPORT window is not opened. ;
* If there are no DEFINE statements and only NUMERIC variables are listed in the COLUMN
*   statement, then PROC REPORT just displays the SUM of each variable.
;

PROC REPORT DATA=patd NOWD;
  COLUMN ptno actevent visdt bthdt sex;
RUN;


* If there is at least one character variable, or at least on DISPLAY, ORDER or 
*   GROUP variable then the SUM of variables are no longer displayed.

* COLUMN HEADERS and COLUMN VALUES are left aligned for character variables, and 
*   right aligned for numeric variables. Formats on numeric values are printed from
*   the left hand side. 
;

PROC REPORT DATA=patd NOWD;
  COLUMN ptno tpatt actevent visdt bthdt sex;
RUN;

PROC REPORT DATA=patd NOWD;
  COLUMN ptno actevent visdt bthdt sex;

  DEFINE ptno / DISPLAY;
RUN;

* The DEFINE statement is used to define how each variable is presented. It is used 
*   to define the attribute (length, label and format) of a variable. It can also 
*   be used to specify if a variable should just be displayed or it should be used 
*   to order the data. 
* If a label is not specified in the DEFINE statement, then the label from the variable
*   will be printed as the column header. If a variable does not already have a label,
*   then the variable name will be printed. To remove a column header then an empty
*   label has to be specified in the DEFINE statement.
;

PROC REPORT DATA=patd NOWD;
  COLUMN ptno actevent visdt bthdt sex;

  DEFINE ptno      / ORDER ;
  DEFINE actevent  / 'Visit number'  FORMAT=5.1;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;
RUN;

* As the visit date is formatted to 5.1, it sets the width of that column to 5 characters. 
*   Hence the word "number" does not fit on one line. In this case it is best to adjust
*   the width.
;

PROC REPORT DATA=patd NOWD;
  COLUMN ptno actevent visdt bthdt sex;

  DEFINE ptno      / ORDER;
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;
RUN;
 
* If there are missing values in an ORDER variable, then these will be dropped.
*   The MISSING option is required to print these observations.
* Note here that ptno=1002 (now '.') only appears in the second table.
;

DATA misspatd;
  SET patd;
  IF ptno=1002 THEN ptno=.;
RUN;

PROC REPORT DATA=misspatd NOWD;
  COLUMN ptno actevent visdt bthdt sex;

  DEFINE ptno      / ORDER;
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;
RUN;
 
PROC REPORT DATA=misspatd NOWD MISSING;
  COLUMN ptno actevent visdt bthdt sex;

  DEFINE ptno      / ORDER;
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;
RUN;
 

* When a variable is specified as an ORDER varible, it orders by the formatted value.
* It also prints each value only once.
* Clearly it will look better if the header SEX was left justified, and perhaps slightly
*   smaller column width.
;

PROC REPORT DATA=patd NOWD MISSING;
  COLUMN sex ptno actevent visdt bthdt;

  DEFINE sex       / ORDER;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;
RUN;
 
* To sort by the actual value as opposed to the formatted value (1=Male, 2=Female), 
*   i.e. so Male is printed first, then we need to specify specify the internal value is
*   used in the sort.
* LEFT in the DEFINE statement will left justify the column.
; 

PROC REPORT DATA=patd NOWD MISSING;
  COLUMN sex ptno actevent visdt bthdt;

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT  WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;
RUN;

* We can enhance the output by adding a line under the column header and a blank line
*   after the column header.
; 

PROC REPORT DATA=patd NOWD MISSING HEADLINE HEADSKIP;
  COLUMN sex ptno actevent visdt bthdt;

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT  WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;
RUN;

* To add a line at the top of the column headers we have to group the variables
*   which we want to cover by the line.
;

PROC REPORT DATA=patd NOWD MISSING HEADLINE HEADSKIP;
  COLUMN ('--' sex ptno actevent visdt bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT  WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;
RUN;

* To add a line at the END of the TABLE we have to calculate the length of the line.
* Length = Sum of all column widths + sum of all spaces between columns
*        = 7(sex) + 10(ptno format=10.) + 7(actevent) + 9(visdt) + 9(bthdt) + (2*4)(spacing) 
*        = 42 + 8 = 50
;

PROC REPORT DATA=patd NOWD MISSING HEADLINE HEADSKIP;
  COLUMN ('--' sex ptno actevent visdt bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT  WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;

  COMPUTE AFTER;
    LINE 50*'_'; 
  ENDCOMP; 
RUN;

* The principle used to add a line at the top can also be applied to add line above 
*   other columns one wishes to group.
;

PROC REPORT DATA=patd NOWD MISSING HEADLINE HEADSKIP;
  COLUMN ('--' sex ptno ('Visit data' '--' actevent visdt) bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT  WIDTH=7;
  DEFINE ptno      / 'Patient number' WIDTH=7;
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;

  COMPUTE AFTER;
    LINE 50*'_'; 
  ENDCOMP; 
RUN;

PROC REPORT DATA=patd NOWD MISSING HEADLINE HEADSKIP;
  COLUMN ('--' sex ptno ('-Visit data-' actevent visdt) bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT  WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;

  COMPUTE AFTER;
    LINE 50*'_'; 
  ENDCOMP; 
RUN;

PROC REPORT DATA=patd NOWD MISSING HEADLINE HEADSKIP;
  COLUMN ('--' sex ptno ('_Visit data_' actevent visdt) bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT  WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;

  COMPUTE AFTER;
    LINE 50*'_'; 
  ENDCOMP; 
RUN;


* Often we would like to have a blank line between groups, this is done with a BREAK
*   statement. 
* However, note that a blank line now appears between the last row and the bottom line.
;

PROC REPORT DATA=patd NOWD MISSING HEADLINE HEADSKIP;
  COLUMN ('--' sex ptno ('_Visit data_' actevent visdt) bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT  WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;

  BREAK AFTER sex / SKIP;

  COMPUTE AFTER;
    LINE 50*'_'; 
  ENDCOMP; 
RUN;

* The line appears as we have said that it should leave a blank line AFTER each 
*   value of sex. To avoid this, we can ask to put a blank line BEFORE each value, and
*   remove HEADSKIP from the PROC REPORT statement.
;

PROC REPORT DATA=patd NOWD MISSING HEADLINE;
  COLUMN ('--' sex ptno ('_Visit data_' actevent visdt) bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT  WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1 WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9.;

  BREAK BEFORE sex / SKIP;

  COMPUTE AFTER;
    LINE 50*'_'; 
  ENDCOMP; 
RUN;

* If the date of birth column was wider then the column header, the header would be printed on 1 line;

PROC REPORT DATA=patd NOWD MISSING HEADLINE;
  COLUMN ('--' sex ptno ('_Visit data_' actevent visdt) bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT     WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1    WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of birth' FORMAT=DATE9. WIDTH=15;

  BREAK BEFORE sex / SKIP;

  COMPUTE AFTER;
    LINE 56*'_'; 
  ENDCOMP; 
RUN;

* In this case, to print the column header across 2 rows we can use a split character.
* SAS will move whatever appears after the defined split character to the next row.
* By default it treats '/' as the split character, but it is best to use a character
* which does not occur too frequently, e.g. '~' or '\'
;

PROC REPORT DATA=patd NOWD MISSING HEADLINE SPLIT='~';
  COLUMN ('--' sex ptno ('_Visit data_' actevent visdt) bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT     WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1    WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of~birth' FORMAT=DATE9. WIDTH=15;

  BREAK BEFORE sex / SKIP;

  COMPUTE AFTER;
    LINE 56*'_'; 
  ENDCOMP; 
RUN;

* By default, there are 2 characters between columns. This can be modified by using
*   the SPACING option. It can be used in the PROC REPORT statement to leave a specified
*   number of characters between columns, and/or in a DEFINE statement, to specify how
*   many characters to leave BEFORE the associated column if printed.
;

PROC REPORT DATA=patd NOWD MISSING HEADLINE SPLIT='~' SPACING=4;
  COLUMN ('--' sex ptno ('_Visit data_' actevent visdt) bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT     WIDTH=7;
  DEFINE ptno      / 'Patient number';
  DEFINE actevent  / 'Visit number'  FORMAT=5.1    WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of~birth' FORMAT=DATE9. WIDTH=15;

  BREAK BEFORE sex / SKIP;

  COMPUTE AFTER;
    LINE 64*'_'; 
  ENDCOMP; 
RUN;

PROC REPORT DATA=patd NOWD MISSING HEADLINE SPLIT='~' SPACING=2;
  COLUMN ('--' sex ptno ('_Visit data_' actevent visdt) bthdt);

  DEFINE sex       / ORDER ORDER=INTERNAL LEFT     WIDTH=7;
  DEFINE ptno      / 'Patient number' SPACING=10;
  DEFINE actevent  / 'Visit number'  FORMAT=5.1    WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of~birth' FORMAT=DATE9. WIDTH=15;

  BREAK BEFORE sex / SKIP;

  COMPUTE AFTER;
    LINE 64*'_'; 
  ENDCOMP; 
RUN;

* FLOW is used to wrap text onto the next line when the width is not long enough. 
* Otherwise the text is truncated.
;

PROC REPORT DATA=patd NOWD MISSING HEADLINE SPLIT='~' SPACING=2;
  COLUMN ('--' tpatt sex ptno ('_Visit data_' actevent visdt) bthdt);

  DEFINE tpatt     / ORDER ORDER=INTERNAL LEFT     WIDTH=7;
  DEFINE sex       / ORDER ORDER=INTERNAL LEFT     WIDTH=7;
  DEFINE ptno      / 'Patient number' SPACING=10;
  DEFINE actevent  / 'Visit number'  FORMAT=5.1    WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of~birth' FORMAT=DATE9. WIDTH=15;

  BREAK BEFORE tpatt / SKIP;

  COMPUTE AFTER;
    LINE 75*'_'; 
  ENDCOMP; 
RUN;

PROC REPORT DATA=patd NOWD MISSING HEADLINE SPLIT='~' SPACING=2;
  COLUMN ('--' tpatt sex ptno ('_Visit data_' actevent visdt) bthdt);

  DEFINE tpatt     / ORDER ORDER=INTERNAL LEFT     WIDTH=12 ;
  DEFINE sex       / ORDER ORDER=INTERNAL LEFT     WIDTH=7;
  DEFINE ptno      / 'Patient number' SPACING=10;
  DEFINE actevent  / 'Visit number'  FORMAT=5.1    WIDTH=7;
  DEFINE visdt     / 'Visit date'    FORMAT=DATE9.;
  DEFINE bthdt     / 'Date of~birth' FORMAT=DATE9. WIDTH=15;

  BREAK BEFORE tpatt / SKIP;

  COMPUTE AFTER;
    LINE 79*'_'; 
  ENDCOMP; 
RUN;

* If you are not sure about the data, and you use the WIDTH option, then also use the
*   FLOW option to avoid text getting truncated. This way at least it is easier to spot 
*   when the width of the column is not wide enough.
;


  ******************************************************************;
  ******************************************************************;
  ******************************************************************;
  ********************                          ********************;
  ********************      EXAMPLE TABLES      ********************;
  ********************                          ********************;
  ******************************************************************;
  ******************************************************************;
  ******************************************************************;

* Make a smaller dataset for reporting *;

DATA sm_phys;
  SET phys (WHERE=(actevent LT 6 AND ptno LT 1010));
RUN;

* For the PHYS dataset * Ability to change labels and use the SPLIT character*;

TITLE 'Report showing use of the SPLIT character';
PROC REPORT DATA=sm_phys NOWD HEADLINE HEADSKIP MISSING SPLIT='~' SPACING=2;
  COLUMNS ('--'  invname ptno actevent dia sys pr);
  DEFINE invname   /ORDER ORDER=INTERNAL WIDTH=15 ;
  DEFINE ptno      /ORDER WIDTH=15 ;
  DEFINE actevent  / WIDTH=15 ;
  DEFINE dia       / WIDTH=15 'Diastolic~blood pressure~[mmHg]';
  DEFINE sys       / WIDTH=15 'Systolic~blood pressure~[mmHg]';
  DEFINE pr        / WIDTH=15 'Pulse rate~[bpm]';
RUN;

* Same Report with added subheading and added format*;

TITLE 'Report with a subheading';
PROC REPORT DATA=sm_phys NOWD HEADLINE HEADSKIP MISSING SPLIT='~' SPACING=2;
  COLUMNS ('--' invname ptno actevent ('-Blood Pressure-' dia sys) pr);
  DEFINE invname   /ORDER ORDER=INTERNAL WIDTH=15 ;
  DEFINE ptno      /ORDER WIDTH=15 ;
  DEFINE actevent  / WIDTH=15 ;
  DEFINE dia       / WIDTH=15 LEFT'Diastolic~blood pressure~[mmHg]';
  DEFINE sys       / WIDTH=15 RIGHT FORMAT=8.2 'Systolic~blood pressure~[mmHg]';
  DEFINE pr        / WIDTH=15 CENTER 'Pulse rate~[bpm]';
RUN;
TITLE;

* Line under the Blood Pressure *;

TITLE 'Report with a line under the subgroup';
PROC REPORT DATA=sm_phys NOWD HEADLINE HEADSKIP MISSING SPLIT='~' SPACING=2;
  COLUMNS ('--' invname ptno actevent ('Blood Pressure'('--' dia sys)) pr);
  DEFINE invname   /ORDER ORDER=INTERNAL WIDTH=15 ;
  DEFINE ptno      /ORDER WIDTH=15 ;
  DEFINE actevent  / WIDTH=15 ;
  DEFINE dia       / WIDTH=15  LEFT 'Diastolic~blood pressure~[mmHg]';
  DEFINE sys       / WIDTH=15  CENTER  FORMAT=6.2 'Systolic~blood pressure~[mmHg]';
  DEFINE pr        / WIDTH=15  RIGHT 'Pulse rate~[bpm]';
RUN;
TITLE;

  ******************************************************************;
  ******************************************************************;
  ******************************************************************;
  ********************                          ********************;
  ********************   FOOTNOTES AND LINE     ********************;
  ********************                          ********************;
  ******************************************************************;
  ******************************************************************;
  ******************************************************************;

TITLE 'Report with bad footnotes';
PROC REPORT DATA=sm_phys NOWD HEADLINE HEADSKIP MISSING SPLIT='~' SPACING=2;
  COLUMNS ('--' invname ptno actevent ('Blood Pressure'('--' dia sys)) pr);
  DEFINE invname   /ORDER ORDER=INTERNAL WIDTH=15 ;
  DEFINE ptno      /ORDER WIDTH=15 ;
  DEFINE actevent  / WIDTH=15 ;
  DEFINE dia       / WIDTH=15  LEFT 'Diastolic~blood pressure~[mmHg]';
  DEFINE sys       / WIDTH=15  CENTER  FORMAT=6.2 'Systolic~blood pressure~[mmHg]';
  DEFINE pr        / WIDTH=15  RIGHT 'Pulse rate~[bpm]';

  FOOTNOTE1 'This is a centered footnote';
  FOOTNOTE2 J=R 'To left justified footnotes, enough blanks can be added after it to make it
 look left justified.                                                                  
                                                                                      ';
FOOTNOTE3 J=R 'It does not read J=L as an error, but it does nothing';
RUN;

TITLE;
FOOTNOTE;

* To solve this problem two equations are necessary...
* Line at the end of the table  and left justify footnotes*;
* Line length is equal to (sum of width of columns) + (sum of spaces between columns) *;
* Defining these as MACRO variables makes changes easier. If column widths change
* then only one number in the linelen statement needs to be changed. *;

%LET tblwidth=%EVAL((6*10)+(5*2));
%PUT &tblwidth.;

* Because footnotes are by default centered, normal FOOTNOTE commands are often not 
* wanted.  This equation will find the position from where to start footnotes.
* footpos is equal to: (((size of the line)-(width of your table))/2)+1
;
%LET footpos=%EVAL(((%SYSFUNC(GETOPTION(linesize))-&tblwidth)/2)+1);

%PUT The line at the bottom should be &tblwidth long.;
%PUT Your footnotes should start at position &footpos;

TITLE 'Report with line as wide as the table and non-centered footnotes ';
PROC REPORT DATA=sm_phys NOWD HEADLINE HEADSKIP MISSING SPLIT='~' SPACING=2;
  COLUMNS ('--' invname ptno actevent  dia sys pr);
  DEFINE invname   /ORDER ORDER=INTERNAL WIDTH=10;
  DEFINE ptno      /ORDER WIDTH=10 ;
  DEFINE actevent  / WIDTH=10 ;
  DEFINE dia       / WIDTH=10  LEFT 'Diastolic~blood pressure~[mmHg]';
  DEFINE sys       / WIDTH=10  CENTER  FORMAT=6.2 'Systolic~blood pressure~[mmHg]';
  DEFINE pr        / WIDTH=10  RIGHT 'Pulse rate~[bpm]';

  COMPUTE AFTER;
    LINE &tblwidth.*'_';
    LINE ' '; *Blank line*;
	  LINE @&footpos '[1] This is a footnote.';
	  LINE ' '; *Blank line*;
    LINE @&footpos '[2] This is another footnote.';
    LINE @&footpos "[3] You can put any characters in this ;,.:!''§$%&/()= or";
    LINE @&footpos "    MACRO variables such as 'tblwidth' &tblwidth";
  ENDCOMP;
RUN;
TITLE;

  ******************************************************************;
  ******************************************************************;
  ******************************************************************;
  ********************                          ********************;
  ********************  PAGE AND LINE  BREAKS   ********************;
  ********************                          ********************;
  ******************************************************************;
  ******************************************************************;
  ******************************************************************;

* With a page break after every investigator name *;
* The break is performed every time the BREAK AFTER variable value changes. *
;
TITLE 'A page break after every investigator name';
PROC REPORT DATA=sm_phys NOWD HEADLINE HEADSKIP MISSING SPLIT='~' SPACING=2;
  COLUMNS ('--' invname ptno actevent ('-Blood Pressure-' dia sys) pr);
  DEFINE invname   /ORDER ORDER=INTERNAL WIDTH=15 ;
  DEFINE ptno      /ORDER WIDTH=15 ;
  DEFINE actevent  / WIDTH=15 ;
  DEFINE dia       / WIDTH=15  LEFT 'Diastolic~blood pressure~[mmHg]';
  DEFINE sys       / WIDTH=15  CENTER  FORMAT=6.2 'Systolic~blood pressure~[mmHg]';
  DEFINE pr        / WIDTH=15  RIGHT 'Pulse rate~[bpm]';

  BREAK AFTER invname / PAGE;

RUN;
TITLE;

TITLE 'A line break after every investigator name';
PROC REPORT DATA=sm_phys NOWD HEADLINE HEADSKIP MISSING SPLIT='~' SPACING=2;
  COLUMNS ('--' invname ptno actevent ('-Blood Pressure-' dia sys) pr);
  DEFINE invname   /ORDER ORDER=INTERNAL WIDTH=15 ;
  DEFINE ptno      /ORDER WIDTH=15 ;
  DEFINE actevent  / WIDTH=15 ;
  DEFINE dia       / WIDTH=15  LEFT 'Diastolic~blood pressure~[mmHg]';
  DEFINE sys       / WIDTH=15  CENTER  FORMAT=6.2 'Systolic~blood pressure~[mmHg]';
  DEFINE pr        / WIDTH=15  RIGHT 'Pulse rate~[bpm]';

  BREAK AFTER invname / SKIP;

RUN;* 

Keep only active medication records *;
PROC SQL;
  CREATE TABLE e_trtexp AS
  SELECT DISTINCT a.study LENGTH=9, a.ptno, a.dcmvisit AS actevent, a.dcmdate AS visdt,
                  a.atrcd, b.regshnm, a.atrstdt, a.atrsttm, a.atrspdt, a.atrsptm
  FROM &lib..e_trtexp a, &lib..e_reg b
  WHERE (a.atrcd=b.label) AND (b.activmed='Y')
  ORDER BY a.study, a.ptno, a.atrstdt, a.atrsttm, a.atrspdt, a.atrsptm;
QUIT;

TITLE;

* Put 2 or 3 or 4 ptno per page *;
* the MOD function returns the remainder of counter divided by 3
* When this is equal to 1 then add one to the break variable ie. when counter=0,4,8
;
* Three per page *;
DATA modbreak;
  SET sm_phys;
  BY ptno;
  IF FIRST.ptno THEN DO;
    counter+1;
		PUT counter=;
    IF MOD(counter,3)=1 THEN break+1;
		counter=1;
		OUTPUT;
  END;
	ELSE output;
RUN;


/* Two per page *
DATA modbreak;
  SET sm_phys;
  BY ptno;
  IF FIRST.ptno THEN DO;
    counter+1;
    IF MOD(counter,2)=1 THEN break+1;
  END;
RUN;

* Four per page *
DATA modbreak;
  SET sm_phys;
  BY ptno;
  IF FIRST.ptno THEN DO;
    counter+1;
    IF MOD(counter,4)=1 THEN break+1;
  END;
RUN;
*/
TITLE 'Break occurs ever time the break variable changes';
PROC PRINT DATA=modbreak (OBS=50) NOOBS ;
  VAR ptno counter break;
RUN;
TITLE;

TITLE 'Show only 3 patients per page';
PROC REPORT DATA=modbreak NOWD HEADLINE HEADSKIP MISSING SPLIT='~' SPACING=2;
  COLUMNS ('--' break ptno  actevent ('-Blood Pressure-' dia sys) pr);
  DEFINE break     / ORDER NOPRINT;
  DEFINE ptno      / ORDER WIDTH=15 ;

  DEFINE actevent  / WIDTH=15 ;
  DEFINE dia       / WIDTH=15  LEFT 'Diastolic~blood pressure~[mmHg]';
  DEFINE sys       / WIDTH=15  CENTER  FORMAT=7.3 'Systolic~blood pressure~[mmHg]';
  DEFINE pr        / WIDTH=15  RIGHT 'Pulse rate~[bpm]';


  BREAK AFTER break / ;
  BREAK AFTER ptno  / PAGE;
  COMPUTE AFTER break; 
    LINE 81*'_';
  ENDCOMP;
RUN;
TITLE;

*Page break within subgroup;
PROC REPORT DATA=modbreak NOWD HEADLINE HEADSKIP MISSING SPLIT='~' SPACING=2;
  COLUMNS ('--' break ptno  actevent ('-Blood Pressure-' dia sys) pr);
  DEFINE break     / ORDER NOPRINT;
  DEFINE ptno      / ORDER WIDTH=15 ;

  DEFINE actevent  / WIDTH=15 ;
  DEFINE dia       / WIDTH=15  LEFT 'Diastolic~blood pressure~[mmHg]';
  DEFINE sys       / WIDTH=15  CENTER  FORMAT=7.3 'Systolic~blood pressure~[mmHg]';
  DEFINE pr        / WIDTH=15  RIGHT 'Pulse rate~[bpm]';


  BREAK AFTER break / ;
  BREAK AFTER ptno  / PAGE;
  COMPUTE AFTER break; 
    LINE 81*'_';
  ENDCOMP;
RUN;
TITLE;


  ******************************************************************;
  ******************************************************************;
  ******************************************************************;
  ********************    USE SQL TO REDUCE     ********************;
  ********************  AMOUNT OF CODE NEEDED   ********************;
  ********************                          ********************;
  ******************************************************************;
  ******************************************************************;
  ******************************************************************;

DATA stdphys;
  SET phys (KEEP=ptno tpatt dia);
  WHERE ptno NE . AND tpatt NE '';
RUN;

PROC SQL NOPRINT;
  CREATE TABLE meansout AS
  SELECT  tpatt, PUT((COUNT(dia)),3.) AS N ,
                 PUT((MEAN(dia)),5.2) AS mean,
                 PUT((MIN(dia)),3.)   AS min,
                 PUT((MAX(dia)),3.)   AS max,
                 PUT((STD(dia)),5.2)  AS sd
  FROM stdphys
  GROUP BY  tpatt
  ORDER BY  tpatt;
QUIT;

PROC MEANS DATA=stdphys NWAY NOPRINT;
  CLASS tpatt;
  VAR dia;
  OUTPUT OUT=meansout N=n MEAN=mean STD=sd MIN=min MAX=max;
RUN;

PROC TRANSPOSE DATA=meansout OUT=transout NAME=stat;
  ID tpatt;
  VAR n min max mean sd;
RUN;

PROC PRINT DATA=transout;
RUN;

* The subquery is used to sort the data by tpatt without having to use an ORDER BY statement;

*DEFINE dummyblack /WIDTH=10 FLOW "DUMMYBLACK";
*DEFINE dummyblue /WIDTH=10 FLOW "dummylue";
*DEFINE dummygreen /WIDTH=10 FLOW "dummygreen";
*DEFINE dummyred /WIDTH=10 FLOW "dummyred";

PROC REPORT DATA=transout HEADLINE HEADSKIP NOWD SPLIT='\' MISSING SPACING=2;
  COLUMNS ('--' stat &_tpatt. dummyblack dummyblue...);
  DEFINE stat /WIDTH=10 FLOW 'Statistic';
/*  &_deftrt.;*/
*DEFINE dummyblack /WIDTH=10 FLOW "DUMMYBLACK"; 
	*DEFINE dummyblue /WIDTH=10 FLOW "dummylue";
*DEFINE dummygreen /WIDTH=10 FLOW "dummygreen";
*DEFINE dummyred /WIDTH=10 FLOW "dummyred";
RUN;

PROC SQL ;
  SELECT  'DEFINE '||tpatt||' /WIDTH=10 FLOW "'||
                  TRIM(UPCASE(tpatt))||'";',
                  tpatt
         INTO :_deftrt SEPARATED BY ' ',
		      :_tpatt  SEPARATED BY ' '
  FROM (SELECT DISTINCT tpatt
        FROM meansout);
QUIT;

%PUT "Define statements will look like &_deftrt";
%PUT "Treatments are &_tpatt";

PROC REPORT DATA=transout HEADLINE HEADSKIP NOWD SPLIT='\' MISSING SPACING=2;
  COLUMNS ('--' stat &_tpatt.);
  DEFINE stat /WIDTH=10 FLOW 'Statistic';
  &_deftrt.;
RUN;


  ******************************************************************;
  ***                                                            ***;
  ***                      END OF PROGRAM                        ***;
  ***                                                            ***;
  ******************************************************************;
