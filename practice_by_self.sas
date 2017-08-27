/*Problem:1
Create a Data set named Patient_demo where PTNO will be 100 to 1010,
ACTEVENT will be 1 to 5 per petient and the sex will be 50% male and 50% female.

*/

/*Problem:2
How many number is divisible by 5 between 106 to 201.
*/

/*Problem:3
Find the prime numbers between 5 to 100.
*/

/*Problem:4
You have 1000 taka to diposit in a bank. If the bank provides 10% interest rate
find the amount of interest for every year of 1 to 20; 
*/

/*Problem:5
 Find all the odd integer betwen 22 to 100;
Find all the even integer betwen 22 to 100;
*/


DATA patient_demo(DROP=i j x y z);

 DO i=1001 TO 1010 BY 1;
 PTNO=i;
/*****Find Odd or Even******/
 x=i/2;
 y=INT(x);
 z=y*2;
 IF(z=i) THEN SEX="FEMALE";
 ELSE SEX="MALE";
/***************************/
 DO j=1 TO 5 BY 1;
 ACTEVENT=j;
 OUTPUT;
 END;

 END;

RUN;

/*Problem:2
How many number is divisible by 5 between 106 to 201.
*/

DATA diviseible;
   count=0;
  DO i=106 TO 201;
    x=mod(i,5);
   IF(x=0) THEN count=count+1;
   END;
RUN;


/*Problem:3
Find the prime numbers between 5 to 100.
*/
DATA Prime_number(KEEP=count);
  count=0;
  PUTLOG "Here the prime numbers:";
  DO i=5 TO 100 BY 1;
  rt=sqrt(i);
  flag=0;
	DO j=2 TO rt BY 1;
	  x=mod(i,j);
	  IF(x=0) THEN DO flag=1; LEAVE; END;
/*	  OUTPUT;	*/
	END;
   IF(flag=0) THEN DO count=count+1; PUT i=;END;
   END;

RUN;


/*Problem:4
You have 1000 taka to diposit in a bank. If the bank provides 10% interest rate
find the amount of interest for every year of 1 to 20; 
*/

DATA int_rate(DROP=rate i);
  amount=1000;
  rate=0.10;
 
  DO i=1 TO 20 BY 1;
      interest=amount*rate;
	  amount=amount+interest;
	  OUTPUT;	
  END;
   
RUN;

