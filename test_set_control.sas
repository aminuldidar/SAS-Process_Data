LIBNAME Testlib 'D:\Testlib';

DATA Testlib.Test_5;
   
  SET Testlib.Test_3 END=f;
  
	IF(_N_>10) THEN DO; ff=1; PUTLOG _ALL_; OUTPUT; STOP; END;
    OUTPUT;
	PUTLOG _ALL_;

  PUT "f is true";

RUN;



LIBNAME Testlib 'D:\Testlib';

DATA Testlib.Test_5;
   
 SET Testlib.Test_3 END=f;
   OUTPUT;
   IF(f) THEN DO; 
         SET Testlib.Test_1 ; 
         OUTPUT; 
     END;
RUN;


DATA Testlib.Test_2;
   
  SET Testlib.Test_2(DROP=n nr);

  /*   IF(_N_>28) THEN OUTPUT; */
    
RUN;

DATA Testlib.Test_5;

  SET Testlib.Test_1(IN=A WHERE=(sex=2)) Testlib.Test_2(IN=B);

  PUT _ALL_;
     testA=A;
     testB=B;
  IF(testB) THEN DO; IF(sex=2) THEN OUTPUT; END;
  IF(testA) THEN OUTPUT;
    
RUN;
