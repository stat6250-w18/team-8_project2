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
%include '.\STAT6250-01_w18-team-8_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: When is the most frequent time called the fire department?'
;

title2
'Rationale: Known the peak time when the people calling, would help the fire department to better assign the human resources.'
;

footnote1
'The most frequent time people called the fire department was at 4-5 PM. 48.24% of the calls happened during 11 AM to 8 PM.'
;

*

Methodology: Create format with 24 values indicated the 24 hours interval of 
the day. Use timepart function to separate the time from the datetime variable,
then applied the user defined format to the time variable. Use PROC FREQ to get
the list of the frequency of the calling time, use order=freq option to list 
the frequency by descending order to know the most frequent time people called
the fire department. 

Limitations: Missing values in the dataset are not counted.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.
;

proc format;
value mytimefmt
low-<'01:00:00't='12-1 AM'
'01:00:00't-<'02:00:00't='1-2 AM'
'02:00:00't-<'03:00:00't='2-3 AM'
'03:00:00't-<'04:00:00't='3-4 AM'
'04:00:00't-<'05:00:00't='4-5 AM'
'05:00:00't-<'06:00:00't='5-6 AM'
'06:00:00't-<'07:00:00't='6-7 AM'
'07:00:00't-<'08:00:00't='7-8 AM'
'08:00:00't-<'09:00:00't='8-9 AM'
'09:00:00't-<'10:00:00't='9-10 AM'
'10:00:00't-<'11:00:00't='10-11 AM'
'11:00:00't-<'12:00:00't='11-12 AM'
'12:00:00't-<'13:00:00't='12-1 PM'
'13:00:00't-<'14:00:00't='1-2 PM'
'14:00:00't-<'15:00:00't='2-3 PM'
'15:00:00't-<'16:00:00't='3-4 PM'
'16:00:00't-<'17:00:00't='4-5 PM'
'17:00:00't-<'18:00:00't='5-6 PM'
'18:00:00't-<'19:00:00't='6-7 PM'
'19:00:00't-<'20:00:00't='7-8 PM'
'20:00:00't-<'21:00:00't='8-9 PM'
'21:00:00't-<'22:00:00't='9-10 PM'
'22:00:00't-<'23:00:00't='10-11 PM'
'23:00:00't-high='11-12 PM'
other='n/a';
run;

data calls_received_time;
set SF_Fire_1617_analytic_file;
received_time=timepart(Received_DtTm);
format received_time mytimefmt.;
run;

proc freq data = calls_received_time order=freq;
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
'The top 5 zip codes had most fire incidents are 94103, 94102, 94109, 94110, and 94124. 48.59% of the fire incidents were happened in these areas.'
;

*

Methodology: Use PROC FREQ with order=freq option to list the frequency of the
zip codes.

Limitations: This methodology does not account for calls with missing data, 
nor does it attempt to validate the data in any way.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.
;

proc freq data = SF_Fire_1617_analytic_file order=freq;
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

Methodology: When combined the data, caculated the difference between
"Dispatch_DtTm", and "Received_DtTm", and create a new variable named timediff.
Then use proc mean to caculate the average time difference.

Limitations: The missing data will affect the average result.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.
;

data response_time_diff (drop=received_date);
set SF_Fire_1617_analytic_file;
received_date=datepart(Received_DtTm);

Fire_calls_year=year(received_date);



timediff=intck('second',Received_DtTm,Dispatch_DtTm);
run;
proc means data = response_time_diff;
    var timediff;
run;

title;
footnote;


