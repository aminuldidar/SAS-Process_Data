LIBNAME testlib 'D:\Testlib';
DATA testlib.Atest;
  DO i=1 TO 5;
     OUTPUT;
	 ver+1;
	 OUTPUT;
	 ver+1;
  END;
run;
