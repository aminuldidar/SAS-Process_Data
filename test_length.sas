/*Find the maximum length of a variable and set the lenth as maximum length*/
DATA test1;
	LENGTH x $10.;
	x=" ";
	OUTPUT;
	x="LSAJX";
	OUTPUT;
RUN;

DATA test2;
	LENGTH x $10.;

	DO x=" ","LSAJX", "ASX", "asdsadasd", "asd";
		OUTPUT;
	END;
RUN;

DATA test3;
	LENGTH x $10.;

	DO x=" "," ", " ", " ", " ";
		OUTPUT;
	END;

RUN;

DATA test4;
	RETAIN mxval 0;
	SET test1;
		pqr=x;
	 ln=LENGTH(x);
	 IF(mxval<ln) THEN mxval=ln;
	 CALL SYMPUT('mxvl', PUT(mxval, BEST12.));
RUN;

%PUT &mxvl.;

DATA test5(KEEP=x);
	LENGTH x $&mxvl.;
	SET test4(DROP=x);
		x = pqr;
RUN;
