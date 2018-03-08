*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
[Dataset 1 Name] SF_Fire_Calls_2017

[Dataset Description] San Francisco Fire Department Calls for Service in 2017

[Experimental Unit Description] The calls that the San Francisco Fire Department 
has responded to in 2017.

[Number of Observations] 312,471

[Number of Features] 34

[Data Source] The file was downloaded into an xlsx format from
https://data.sfgov.org/Public-Safety/Fire-Department-Calls-for-Service/nuek-vuh3
and then the Call Date was filtered for 2017.

[Data Dictionary]https://data.sfgov.org/api/views/nuek-vuh3/files/ddb7f3a9-0160-4f07-bb1e-2af744909294?download=true&filename=FIR-0002_DataDictionary_fire-calls-for-service.xlsx

[Unique Id Schema] The column Call Number is the unique id.

--

[Dataset 2 Name] SF_Fire_Calls_2016

[Dataset Description] San Francisco Fire Department Calls for Service in 2016

[Experimental Unit Description] The calls that the San Francisco Fire Department 
has responded to in 2016.

[Number of Observations] 303,967

[Number of Features] 34

[Data Source] The file was downloaded into an xlsx format from
https://data.sfgov.org/Public-Safety/Fire-Department-Calls-for-Service/nuek-vuh3
and then the Call Date was filtered for 2016.

[Data Dictionary]https://data.sfgov.org/api/views/nuek-vuh3/files/ddb7f3a9-0160-4f07-bb1e-2af744909294?download=true&filename=FIR-0002_DataDictionary_fire-calls-for-service.xlsx

[Unique Id Schema] The column Call Number is the unique id.

--

[Dataset 3 Name] SF_Fire_Incidents_2017

[Dataset Description] San Francisco Fire Department Incidents in 2017

[Experiment Unit Description] The non-medical incidents that the San Francisco 
Fire Department has responded to in 2017.

[Number of Observations] 31,020

[Number of Features] 63

[Data Source] https://data.sfgov.org/Public-Safety/Fire-Incidents/wr8u-xric
The dataset was downloaded into an xlsx format and then filtered by Incident 
Date to just include data for 2017.

[Data Dictionary] https://data.sfgov.org/api/views/wr8u-xric/files/54c601a2-63f1-4b27-a79d-f484c620f061?download=true&filename=FIR-0001_DataDictionary_fire-incidents.xlsx

[Unique ID Schema] The column Call Number is the unique id.

--

[Dataset 4 Name] SF_Fire_Incidents_2016

[Dataset Description] San Francisco Fire Department Incidents in 2016

[Experiment Unit Description] The non-medical incidents that the San Francisco 
Fire Department has responded to in 2016.

[Number of Observations] 31,856

[Number of Features] 63

[Data Source] https://data.sfgov.org/Public-Safety/Fire-Incidents/wr8u-xric
The dataset was downloaded into an xlsx format and then filtered by Incident 
Date to just include data for 2016.

[Data Dictionary] https://data.sfgov.org/api/views/wr8u-xric/files/54c601a2-63f1-4b27-a79d-f484c620f061?download=true&filename=FIR-0001_DataDictionary_fire-incidents.xlsx

[Unique ID Schema] The column Call Number is the unique id.
;


*environmental setup;

*create output formats;

proc format;
    value time_bins
      low -< '01:00:00't = '12-1 AM'
      '01:00:00't -< '02:00:00't = '1-2 AM'
      '02:00:00't -< '03:00:00't = '2-3 AM'
      '03:00:00't -< '04:00:00't = '3-4 AM'
      '04:00:00't -< '05:00:00't = '4-5 AM'
      '05:00:00't -< '06:00:00't = '5-6 AM'
      '06:00:00't -< '07:00:00't = '6-7 AM'
      '07:00:00't -< '08:00:00't = '7-8 AM'
      '08:00:00't -< '09:00:00't = '8-9 AM'
      '09:00:00't -< '10:00:00't = '9-10 AM'
      '10:00:00't -< '11:00:00't = '10-11 AM'
      '11:00:00't -< '12:00:00't = '11-12 AM'
      '12:00:00't -< '13:00:00't = '12-1 PM'
      '13:00:00't -< '14:00:00't = '1-2 PM'
      '14:00:00't -< '15:00:00't = '2-3 PM'
      '15:00:00't -< '16:00:00't = '3-4 PM'
      '16:00:00't -< '17:00:00't = '4-5 PM'
      '17:00:00't -< '18:00:00't = '5-6 PM'
      '18:00:00't -< '19:00:00't = '6-7 PM'
      '19:00:00't -< '20:00:00't = '7-8 PM'
      '20:00:00't -< '21:00:00't = '8-9 PM'
      '21:00:00't -< '22:00:00't = '9-10 PM'
      '22:00:00't -< '23:00:00't = '10-11 PM'
      '23:00:00't - high = '11-12 PM'
      other = 'n/a'
    ;
run;


*setup environmental parameters;

%let inputDataset1URL =
https://github.com/stat6250/team-8_project2/blob/master/data/Fire_Calls_2016.xlsx?raw=true
;
%let inputDataset1Type = xlsx;
%let inputDataset1DSN = Fire_Calls_2016_raw;

%let inputDataset2URL =
https://github.com/stat6250/team-8_project2/blob/master/data/Fire_Calls_2017.xlsx?raw=true
;
%let inputDataset2Type = xlsx;
%let inputDataset2DSN = Fire_Calls_2017_raw;

%let inputDataset3URL =
https://github.com/stat6250/team-8_project2/blob/master/data/Fire_Incidents_2016.xlsx?raw=true
;
%let inputDataset3Type = xlsx;
%let inputDataset3DSN = Fire_Incidents_2016_raw;

%let inputDataset4URL =
https://github.com/stat6250/team-8_project2/blob/master/data/Fire_Incidents_2017.xlsx?raw=true
;
%let inputDataset4Type = xlsx;
%let inputDataset4DSN = Fire_Incidents_2017_raw;


* load raw datasets over the wire, if they doesn't already exist;

%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile "%sysfunc(getoption(work))/tempfile.xlsx";
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;
%loadDataIfNotAlreadyAvailable(
    &inputDataset1DSN.,
    &inputDataset1URL.,
    &inputDataset1Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset2DSN.,
    &inputDataset2URL.,
    &inputDataset2Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset3DSN.,
    &inputDataset3URL.,
    &inputDataset3Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset4DSN.,
    &inputDataset4URL.,
    &inputDataset4Type.
)


* sort and check raw datasets for duplicates with respect to their unique ids, 
removing blank rows, if needed;

proc sort
        nodupkey
        data=Fire_Calls_2016_raw
        dupout=Fire_Calls_2016_dups
        out=Fire_Calls_2016_raw_sorted(where=(not(missing(Call_Number))))
    ;
    by
        Call_Number
    ;
run;

proc sort
        nodupkey
        data=Fire_Calls_2017_raw
        dupout=Fire_Calls_2017_dups
        out=Fire_Calls_2017_raw_sorted
    ;
    by
        Call_Number
    ;
run;

proc sort
        nodupkey
        data=Fire_Incidents_2016_raw
        dupout=Fire_Incidents_2016_raw_dups
        out=Fire_Incidents_2016_raw_sorted
    ;
    by
        Call_Number
    ;
run;

proc sort
        nodupkey
        data=Fire_Incidents_2017_raw
        dupout=Fire_Incidents_2017_raw_dups
        out=Fire_Incidents_2017_raw_sorted
    ;
    by
        Call_Number
    ;
run;


* create new variable named "received_time" by using time part function to 
extract the time from datetime variable "Received_DtTm", create new variable
named "received_date" by using datepart function to extract the date from 
datetime variable "Received_DtTm", then create the new variable named "year" by
using year function to extract the year, finally, apply the user defined format
to the new created variable "received_time".;

data Fire_Calls_2016_raw_sorted (drop=received_date);
	set Fire_Calls_2016_raw_sorted
	;
	received_time = timepart(Received_DtTm)
	;
	received_date = datepart(Received_DtTm)
	;
	year = year(received_date)
	;
    format received_time time_bins.;
run;

data Fire_Calls_2017_raw_sorted (drop=received_date);
	set Fire_Calls_2017_raw_sorted
	;
	received_time = timepart(Received_DtTm)
	;
	received_date = datepart(Received_DtTm)
	;
	year = year(received_date)
	;
    format received_time time_bins.;
run;

 
*convert variable values of number_of_floors_with_extreme_da and number_of_alarms
from numeric to character due variables being defined as more than one type.;

data Fire_Incidents_2016_raw_sorted;
    set Fire_Incidents_2016_raw_sorted
    ;
    num1 = input(number_of_floors_with_extreme_da,best12.)
    ;
    num2 = input(number_of_alarms,best12.)
    ;
    drop number_of_floors_with_extreme_da number_of_alarms
    ;
    rename num1 = number_of_floors_with_extreme_da
    ;
    rename num2 = number_of_alarms
    ;
run;

data Fire_Incidents_2017_raw_sorted;
    set Fire_Incidents_2017_raw_sorted
    ;
    num1 = input(number_of_floors_with_extreme_da,best12.)
    ;
    num2 = input(number_of_alarms,best12.)
    ;
    drop number_of_floors_with_extreme_da number_of_alarms
    ;
    rename num1 = number_of_floors_with_extreme_da
    ;
    rename num2 = number_of_alarms
    ;
run;


* combine Fire_Calls_2016 and Fire_Calls_2017 vertically and combine 
Fire_Incidents_2016 and Fire_Incidents_2017 vertically using proc sql which
overlays the columns that have the same name in both datasets and does not 
exclude duplicate rows;

proc sql;
    create table Fire_Calls_1617 as
        select 
	    * 
	from 
	    Fire_Calls_2016_raw_sorted
    union corresponding all
        select 
	    * 
	from 
	    Fire_Calls_2017_raw_sorted
    ;
quit;

proc sql;
    create table Fire_Incidents_1617 as
        select 
	    * 
	from 
	    Fire_Incidents_2016_raw_sorted
    union corresponding all
        select
	    * 
	from
	    Fire_Incidents_2017_raw_sorted
    ;
quit;


* combine Fire_Calls_1617 and Fire_Incidents_1617 horizontally, create a new
variable named "timediff" by sustract the column "Dispatch_DtTm" from
Fire_Incidents_1617 file, with the column "Received_DtTm" from Fire_Calls_1617
file, to calculate the time difference in seconds between the time of the calls
received and the time of the first unit been dispatched. To build analytic
dataset from raw datasets with the least number of columns and minimal
cleaning/transformation needed to address research questions in corresponding
data-analysis files;

data SF_Fire_1617_analytic_file;
    retain
        Call_Number
        Call_Type
        Area_of_Fire_Origin
        Neighborhooods___Analysis_Bounda
        Received_DtTm
        Entry_DtTm
        Dispatch_DtTm
        Zipcode_of_Incident
        received_time
        year
        timediff
    ;
    keep
        Call_Number
        Call_Type
        Area_of_Fire_Origin
        Neighborhooods___Analysis_Bounda
        Received_DtTm
        Entry_DtTm
        Dispatch_DtTm
        Zipcode_of_Incident
        received_time
        year
        timediff
    ;
    merge
        Fire_Calls_1617(rename=(supervisor_district = supervisor_district_num))
        Fire_Incidents_1617
    ;
    by
	Call_Number
    ;
    if
        not(missing(compress(supervisor_district_num,'.','kd')))
then
    do;
        supervisor_district = put(supervisor_district_num,4.);
    end;
else
    do;
        call missing(supervisor_district);
    end;
	timediff = intck('second',Received_DtTm,Dispatch_DtTm)
    ;
run;


*use proc sort to create a temporary sorted table by year;

proc sort 
        data=SF_Fire_1617_analytic_file 
        out=SF_Fire_1617_analytic_file_sort
    ;
    by 
	year
    ;
run;


* use proc freq to create a frequency table and then use proc sort to create 
a temporary sorted table in descending order by Count_Fire_Origin;

proc freq
       data = SF_Fire_1617_analytic_file noprint
   ;
   table
       Area_of_Fire_Origin / out = Count_Fire_Origin list
   ;
       where 
           not(missing(Area_of_Fire_Origin));
   ;
run;

proc sort
       data = Count_Fire_Origin
       out = Count_Fire_Origin_Desc 
   ;
   by
       descending count
   ;
run;


* use proc freq to create a frequency table and then use proc sort to create 
a temporary sorted table in descending order by Count_Call_Type;

proc freq
       data = SF_Fire_1617_analytic_file noprint
   ;
   table
       Call_Type / out = Count_Call_Type list
   ; 
       where 
           not(missing(Call_Type));
   ;
run;

proc sort
       data = Count_Call_Type
       out = Count_Call_Type_Desc
   ;
   by
       descending count
   ;
run;


* apply the percent format to the Count_Call_Type;

data Count_Call_Type
    ;
    set Count_Call_Type
    ;
    label pct = 'Percent'
    ;
    format pct percent.
    ;
    pct = percent/100
    ;
run;
  
  
* use proc freq to create a frequency table and then use proc sort to create 
a temporary sorted table in descending order by Count_Neighborhooods;

proc freq
       data = SF_Fire_1617_analytic_file noprint
   ;
   table
       Neighborhooods___Analysis_Bounda / out = Count_Neighborhooods list
   ;
    where 
       not(missing(Neighborhooods___Analysis_Bounda));
run;

proc sort
       data = Count_Neighborhooods
       out = Count_Neighborhooods_Desc
   ;
   by
       descending count
   ;
run;
