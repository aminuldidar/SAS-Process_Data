LIBNAME Testlib 'D:\Testlib';
DATA Testlib.Test_4;
SET Testlib.test_1 END=f;
  flg=f;
/*PUTLOG _ALL_;*/
OUTPUT;
if(flg) THEN 
  DO i=1 TO 5 BY 1;
   flg=flg+2;
   OUTPUT;
  END;

RUN;
