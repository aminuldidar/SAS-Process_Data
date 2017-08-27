%MACRO test(cond);
  %LET cn= &cond.;
  %LET cr=&cn.;
  DATA conest;
  	x="6";
  	IF(&cr.) THEN Y=10;
  RUN;
%MEND test;

%test(cond= x EQ "5");
