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
'Research Question: When is the most frequent time called the fire department?'
;

title2
'Rationale: Known the peak time when the people calling, would help the fire department to better assign the human resources.'
;

footnote1
'The most frequent time people called the fire department was at 4-5 PM. 48.24% of the calls happened during 11 AM to 8 PM.'
;

*

Methodology: Use PROC FREQ to get the list of the frequency of the calling 
time, use order=freq option to list the frequency by descending order to know 
the most frequent time people called the fire department. 

Limitations: Missing values in the dataset are not counted.

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data.
;

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

Methodology: Use proc mean to caculate the average time difference between the
time of the calls received and the time of the first unit been dispatched in
2016 and 2017.

Limitations: There are missing datas. There are negative time differences which
are not making any sences. Caculate the mean in the year level is a not good
choice to compare the response effiency, use the mean in the weekly, monthly,
or quarterly level will be better. 

Followup Steps: More carefully clean values in order to filter out any possible 
illegal values, and better handle missing data. Caculate the time differences
in defferent level (weekly, monthly, and quarterly).
;

proc means data = response_time_diff;
    var timediff;
run;

title;
footnote;


