*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding San Francisco Fire Department Calls and Incidents during
2016 and 2017.

Dataset Name: SF_Fire_1617_analytic_file created in external file
STAT6250-01_w18-team-8_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset SF_Fire_1617_analytic_file;
%include '.\STAT6250-01_w18-team-8_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: What are the top five areas of fire origin?'
;

title2
'Rationale: This would determine where the majority of fires are started.'
;

footnote1
"The majority of fires in San Francisco in 2016 and 2017 were in the cooking area (kitchen)."
;

footnote2
"The other top four areas were undetermined, other area of fire origin, engine area, and the outside area."
;

footnote3
"Further investigation as to what other area of fire origin represents should be done to get a better picture."
;

footnote4
"Also getting more details on what classifies a fire origin as undetermined would give more insight into the data."
;

footnote5
"Ultimately, the data shows that the majority of fires start in the cooking areas, which goes to show that in order to prevent fires more caution should be taken when in the cooking areas (kitchen)."
;

*
Note: This compares the column "Call Number" from Fire_Incidents_2016
to the column of the same name from Fire_Incidents_2017 to combine the column
"Area of Fire Origin" from each year that has a unique call number.

Methodology: Use PROC FREQ to generate a frequency table based on the dataset
that counts the Area_of_Fire_Origin. Then, use PROC SORT to temporarily sort 
the data by descending count, in order to find the top three areas of fire 
origin. Finally, use PROC PRINT to determine the top five most common areas of 
fire origin.

Limitations: This methodology does not account for calls with missing data, 
nor does it attempt to validate the data in any way.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.

;

proc print
       data = Count_Fire_Origin_Desc (obs=5)
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

Note: This compares the column "Call Number" from Fire_Calls_2016
to the column of the same name from Fire_Calls_2017 to combine the column
"Call Type" from each year that has a unique call number.

Methodology: Use PROC FREQ to generate a frequency table based on the dataset
that counts the Call_Type. Then, use PROC SORT to temporarily sort the data by
descending count, to find the most common call type. Use PROC PRINT 
to print the most common call type. Conver the data to the percent format in 
order to create a graph based on the frequency percentages. 

Limitations: This methodology does not account for calls with missing data, 
nor does it attempt to validate the data in any way.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.

;

proc print
        data = Count_Call_Type_Desc 
   ;
run;

footnote1
"The majority of call types the the San Francisco Fire Department received in 2016 and 2017 were medical incidents, which accounted for 76% of the calls."
;

footnote2
"A few other common call types were alarms (7.6%), structure fire (4%), traffic collision (3.4%), other (2.5%), citizen assist/service call (2.2%),and outside fire (1.7%)."
;

footnote3
"The rest of the call types were less than one percent."
;

footnote4
"Therefore, the San Francisco Fire Department should of course be prepared for every call, but should be better prepared for medicial incident calls."
;

proc sgplot
        data = Count_Call_Type 
   ;
   hbar Call_Type / response=pct datalabel
   ;
   title 'Call Type Frequency'
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

footnote1
"The neighborhood district that made the most fire calls in San Francisco in 2016 and 2017 was Tenderloin with 41,595 calls."
;

footnote2
"Some other districts with quite a few fire calls were South of Market (31,246 calls), Mission (27,424 calls), Financial District/South Beach (20,656 calls), and Bayview Hunters Point (14,591 calls)."
;

footnote3
"The next step would be to look at how many fire stations are located in these neighborhoods and whether that is enough for how many calls they are recieving."
;

footnote4
"Also, further investigation into the majority of call types that these stations in these neighborhoods are recieving would help prepare the fire station for these type of calls."
;

*

Note: This compares the column "Call Number" from Fire_Calls_2016
to the column of the same name from Fire_Calls_2017 to combine the column
"Neighborhoods Analysis Boundary" from each year that has a unique call 
number.

Methodology: Use PROC FREQ to generate a frequency table based on the dataset
that counts the Neighborhooods___Analysis_Bounda. Then, use PROC SORT to 
temporarily sort the data by descending count, to find the neighborhoods that 
made the most fire calls for service. Finally, use PROC PRINT to print the
neighborhoods that made the most fire calls for service.

Limitations: This methodology does not account for calls with missing data, 
nor does it attempt to validate the data in any way.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.

;

proc print
        data = Count_Neighborhooods_Desc 
   ;
run;
title;
footnote;
