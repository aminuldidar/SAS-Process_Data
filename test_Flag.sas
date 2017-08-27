/*******After Concat First Obs and Last Obs Without first. and last. *********/
LIBNAME Testlib 'D:\Testlib';
DATA Testlib.Test_1;
SET Testlib.test;
  n=_N_;
  
RUN;


LIBNAME Testlib 'D:\Testlib';

DATA Testlib.Test_2;
RETAIN flg f;
 SET Testlib.All_test(IN=A) Testlib.Test_1(IN=B);

RUN;

LIBNAME Testlib 'D:\Testlib';
DATA Testlib.Test_3;
 SET Testlib.Test_2;
   nn=_N_;
  IF(n=1) THEN var=1;
  else var=0;
RUN;

PROC SORT DATA=Testlib.Test_3;
BY DECENDING nn;
RUN;

LIBNAME Testlib 'D:\Testlib';
DATA Testlib.Test_4;
RETAIN Hold;
 SET Testlib.Test_3;
   IF(Hold=1) THEN var=1;
   Hold=n;
   IF(_N_=1) THEN var=1;
  
RUN;

PROC SORT DATA=Testlib.Test_4;
BY nn;
RUN;


/*Another Efficient way*/

LIBNAME Testlib 'D:\Testlib';
DATA Testlib.Test_1;
SET Testlib.Test_1;
  IF(_N_=1) THEN n=1;
  ELSE n=0; 
  nr=_N_;
RUN;

PROC SORT DATA=Testlib.Test_1;
BY DECENDING nr;
RUN;

DATA Testlib.Test_1;
SET Testlib.Test_1;
  IF(_N_=1) THEN n=1;
  ELSE IF(n^=1) THEN n=0; 
  nr=_N_;
RUN;


DATA Testlib.All_test;
SET Testlib.All_test;
  IF(_N_=1) THEN n=1;
  ELSE n=0; 
  nr=_N_;
RUN;

PROC SORT DATA=Testlib.All_test;
BY DECENDING nr;
RUN;

DATA Testlib.All_test;
SET Testlib.All_test;
  IF(_N_=1) THEN n=1;
  ELSE IF(n^=1) THEN n=0; 
  nr=_N_;
RUN;

LIBNAME Testlib 'D:\Testlib';
DATA Testlib.Test_2;
 SET Testlib.Test_1(IN=B) Testlib.All_test(IN=A);
 RUN;

/*Using IN */
 DATA Testlib.Test_3(DROP=fe f2);
  RETAIN f1 f2;
  var=0;
 SET Testlib.Test_1(IN=A) Testlib.Test_2(IN=B);
 testA=A;
 testB=B;
 IF(f1=. AND testA) THEN DO; var=1; f1=1 ; END;
 IF(f1=1 AND testA=0 AND testB=1) THEN DO; var=1; f1=0 ; END;

RUN;
