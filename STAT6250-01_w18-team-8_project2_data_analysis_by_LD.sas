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
'Research Question: When is the most frequent time people called the fire department in 2016, and 2017?'
;

title2
'Rationale: Known the peak time when the people calling, would help the fire department to better assign the human resources.'
;

footnote1
'The most frequent time people called the fire department in 2016 was at 5-6 PM, in 2017 was at 4-5pm.'
;

footnote2
'Moreover, 53.08% of the calls happened from 10 am to 8 pm in 2016; 53.41% of the calls happend from 10 am to 8 pm in 2017'
;

*
Note: This compares the column "received_time" from Fire_Calls_2016_raw_sorted
to the column of the sam name from Fire_Calls_2017_raw_sorted. 

Methodology: After sort the raw data files, create the new variable called 
received_time by using timepart function to extract the time from the
"Received_DtTm" variable, create the new variable named year by using datepart
function to extract the date from the "Received_DtTm" variable, then use year
function to extract the year for Fire_Calls of 2016 and 2017. Then after merged
all the datasets to create the final analytical file
"SF_Fire_1617_analytic_file" , use proc sort to create a temporary sorted table
by received_time and year. Finally, use PROC FREQ here to get the list of the 
frequency of the calling received_time, use order=freq option to list the 
frequency by descending order to know the most frequent time people called the
fire department in 2016 and 2017. 

Limitations: Missing values in the dataset are not counted.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.
;

proc freq 
		data = SF_Fire_1617_analytic_file_sort order=freq
		;
		by year;
    	tables received_time;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: List the top 5 zip codes had most fire incidents in 2016 and 2017?'
;

title2
'Rationale: Known the places most likely have fires, would help the community and the fire department to take action to prevent it.'
;

footnote1
'The top 5 zip codes had most fire incidents are 94103, 94102, 94109, 94110, and 94124 in 2016. 48.88% of the fire incidents were happened in these areas.'
;

footnote2
'The top 5 zip codes had most fire incidents are 94103, 94102, 94109, 94110, and 94124 in 2017. 48.30% of the fire incidents were happened in these areas'
;

*
Note: This compares the column "Zipcode_of_Incident" from
Fire_Incidents_2016_raw_sorted to the column of the same name from
Fire_Incidents_2017_raw_sorted.

Methodology: We have the new variable "year" created from the 
Fire_Calls_2016_raw_sorted data file step, then after merged all the datasets to
create the final analytical file "SF_Fire_1617_analytic_file" , use proc sort to
create a temporary sorted table by year. Finally, use PROC FREQ here with 
order=freq option to list the frequency of the zip codes where mostly had fire 
incidents in 2016 and 2017.

Limitations: This methodology does not account for calls with missing data, 
nor does it attempt to validate the data in any way.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.
;

proc freq
		data = SF_Fire_1617_analytic_file_sort order=freq
		;
		by year;
    	tables Zipcode_of_Incident;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: How long in average it took from the time received by the dispatch center, to the time the first unit been dispatched in 2016 and 2017?'
;

title2
'Known the time spent for dispatch center to dispatch the first response unit after received the call, can help the dispatch center to improve response efficiency.'
;

footnote:
'The average response time in 2016 was 163 second, in 2017 was 173 second.'
;

*
Note: This compares the column "Received_DtTm" from Fire_Calls_1617 to the
column "Dispatch_DtTm" from Fire_Incidents_1617.

Methodology: When create the final analytical file "SF_Fire_1617_analytic_file",
create the new variable named "timediff" by using INTCK function to calculate 
the time difference in seconds between variable "Dispatch_DtTm" and 
"Received_DtTm". Then use proc sort to create a temporary sorted table by year.
Finally, use proc mean here to caculate the average time difference between the
time of the calls received and the time of the first unit been dispatched in
2016 and 2017.

Limitations: There are missing and invalid datas (for example,there are negative
time differences which are not making any sences, and there were some incidents
took almost 9 hours till dipatched the first unit). Caculate the mean in the
year level is a not good choice to compare the response effiency, use the mean
in the daily, weekly, monthly, or quarterly level will be better. 

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data. Caculate the time differences
in defferent level (daily, weekly, monthly, and quarterly).
;

proc means 
		data = SF_Fire_1617_analytic_file_sort
		;
    	var timediff;
		by year;
run;

title;
footnote;


