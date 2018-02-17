*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding San Francisco Fire Department Calls and Incidents during
2016 and 2017.

Dataset Name: SF_Fire_1617_analytic_file created in external file
STAT6250-02_s17-team-8_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset SF_Fire_1617_analytic_file;
%include '.\STAT6250-02_s17-team-8_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1
'Research Question: What are the top three areas of fire origin?'
;

title2
'Rationale: This would determine where the majority of fires are started.'
;

*

Methodology: Use PROC FREQ to generate a frequency table based on the dataset
that counts the Area_of_Fire_Origin. Then, use PROC SORT to temporarily
sort the data by descending count, in order to find the top three areas of 
fire origin. Finally, use PROC PRINT of the first three observations

Limitations: This methodology does not account for calls with missing data, 
nor does it attempt to validate the data in any way.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.

*

proc freq
       data = SF_Fire_1617_analytic_file
   ;
   table
       Make / out / noprint= FreqCount list
   ;
run;

proc sort
       data = FreqCount
       out = FreqCount_Desc
   ;
   by
       descending count
   ;
run;

proc print
       data = FreqCount_Desc(obs=3)
   ;
run;
title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1
'Research Question: What are the most common call types?'
;

title2
'Rationale: This would determine what calls are more frequent which would allow dispatch to train their employees better in these call types.'
;

*

Methodology: Use PROC FREQ to generate a frequency table based on the dataset
that counts the Call_Type. Then, use PROC SORT to temporarily
sort the data by descending count, to find the most common call type. 
Finally, use PROC PRINT to print the most common call type.

Limitations: This methodology does not account for calls with missing data, 
nor does it attempt to validate the data in any way.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.

*

proc freq
       data = SF_Fire_1617_analytic_file
   ;
   table
       Call_Type / out / noprint = FreqCount list
   ;
run;

proc sort
       data = FreqCount
       out = FreqCount_Desc
   ;
   by
       descending count
   ;
run;

proc print
        data = FreqCount_Desc 
   ;
run;
title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1
'Research Question: Which neighborhood district made the most fire calls for service?'
;

title2
'This would help determine if there needed to be more station areas in certain neighborhoods or if station areas in certain neighborhoods need to be staffed higher.'
;

*

Methodology: Use PROC FREQ to generate a frequency table based on the dataset
that counts the Neighborhooods___Analysis_Bounda. Then, use PROC SORT to 
temporarily sort the data by descending count, to find the neighborhoods that 
made the most fire calls for service. Finally, use PROC PRINT to print the
neighborhoods that made the most fire calls for service.

Limitations: This methodology does not account for calls with missing data, 
nor does it attempt to validate the data in any way.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.

*

proc freq
       data = SF_Fire_1617_analytic_file
   ;
   table
       Neighborhooods___Analysis_Bounda / out / noprint = FreqCount list
   ;
run;

proc sort
       data = FreqCount
       out = FreqCount_Desc
   ;
   by
       descending count
   ;
run;

proc print
        data = FreqCount_Desc 
   ;
run;
title;
footnote;

