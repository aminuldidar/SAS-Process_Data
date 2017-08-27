/*Test 1:*/
DATA _NULL_;
 DO i=0 TO 10 BY 1;
  
  PUT i;

   IF(i=5) THEN i=12;

 END;

RUN;


/*Test 2:*/
DATA _NULL_;
	a=0; b=10; c=2;
	DO i = a TO b BY c; 
  	PUT i=;
  	a=22; b=33; c=44;
	END;
RUN;


/*Test 3:*/
DATA X;
 INPUT ptno visit weight;
 DATALINES;
 2 1 10.2
 2 2 11.3
 2 3 0.8
 2 1 12
 2 2 15
 3 1 10
 3 2 18
 4 1 9
 ;
RUN;



 DATA x3;
      SET x ;
        DO i=1 to 7;
          IF (ptno=i);
           OUTPUT;
        
        END;
      
RUN;

 DATA x3;
      SET x END =eof;
	   PUT _ALL_;
        DO i=1 to 7 BY 1;
		 PUT _ALL_;
          IF (ptno=i);
		  PUT _ALL_;
           OUTPUT;
/*          IF(i=7) THEN OUTPUT;*/
        
        
        END;
      IF(eof) THEN OUTPUT;
RUN;


/*Test 4:*/

*One of the hallmarks of the SAS language and more specifically the DATA step is its implied looping action to read
raw or SAS data.;

DATA One ;
	DO I = 1 TO 10 ;
	 OUTPUT ;
	END;
RUN;


DATA Two ;
PUT 'Before:' _All_ ;
SET One ;
PUT 'After:' _All_ ;
RUN;



/*Test 5:*/

*In the above example the subsetting IFstatement deletes the record with the marked EOF before it could be used by
the IF statement that checks for it. This is a “gotcha” of sorts and something to be aware of. In order to properly test
for EOF, there are two possible solutions: one using the WHERE statement and the other with proper placement of
the IF statement that tests for EOF.;
Data WrongWay ;
Set One End = EOF ;
If ( 1 <= I <= 9 );
If EOF Then I = 99999 ;
Put I= _N_= ;
Run ;


Data RightWay1 ;
Set One End = EOF ;
Where ( 1 <= I <= 9 ) ;
If EOF Then I = 99999 ;
Put I= _N_= ;
Run ;



Data RightWay2 ;
If EOF Then Do ;
I = 9999 ;
Put I= _N_= ;
End ;
Set One End = EOF ;
If ( 1 <= I <= 9 ) ;
Put I= _N_= ;
Run ;


/*Test 6:*/
Data _Null_ ;
Do I = 3 To 1 By -1 ;
Put I= ;
End ;
Run ;


/*Test 7:*/
Data _NULL_ ;
Do I = 1 , 2 , 3 To 1 By -1 ;
Put I= ;
End ;
Run ;


/*Test 8:*/

Data _NULL_ ;
Do I = 0 to 3 , 4 , 3 By -1 While( I > 0 ) ;
Put I= ;
End ;
Run ;


/*Test 9:*/
Data _NULL_ ;
Do I = 0 to 3 , 4 , 3 By -1 While( I > 0 ) ;
Put I= ;
End ;
Run ;


/*Test 10:*/

Data _Null_ ;
I = 0 ;
Do While ( I < 10 ) ;
Put I= ;
I + 1 ;
End ;
Run ;

/*Test 11:*/

*The RETURN statement returns control to the top of the DATA step. In all DATA steps there is an implied RETURN
statement just before the RUN statement. Using a RETURN statement in the context of a DO-loop is odd, but
possible.;

Data _Null_ ;
Do I = 1 To 5 ;
If I = 3 Then Return ;
Put I= ;
End ;
Run ;

*In the above example while the value of I is less than 3, the values of I are written out to the log. When the value of
I reached 3, the RETURN statement is executed and control passes out of the DO-loop and back to the top of the
DATA step. At this point the DATA step stops execution as there is no incoming data from a data set or file and it has
already executed once;


Data _Null_ ;
SET one;
Do I = 1 To 5 ;
If I = 3 Then Return ;
Put I= ;
End ;
Run ;
