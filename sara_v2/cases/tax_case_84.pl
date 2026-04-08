% Text
% Bob and Alice got married on Feb 3rd, 1992. Bob and Alice have a child, Charlie, born October 9th, 2000. Bob died on July 9th, 2014. From 2004 to 2019, Alice furnished the costs of maintaining the home where he and Charlie lived during that time. Alice's gross income for the year 2017 is $25561. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $2574

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Bob").
agent_("married","Alice").
start_("married","1992-02-03").
death_("died").
agent_("died","Bob").
start_("died","2014-07-09").
end_("died","2014-07-09").
son_("child").
agent_("child","Charlie").
patient_("child","Bob").
patient_("child","Alice").
start_("child","2000-10-09").
residence_("lived").
agent_("lived","Charlie").
agent_("lived","Alice").
patient_("lived","the home").
start_("lived","2004-01-01").
end_("lived","2019-12-31").
alice_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2004,2019,Year),
    atom_concat("furnished the costs ",Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- alice_household_maintenance(_,Event,_,_).
agent_(Event,"Alice") :- alice_household_maintenance(_,Event,_,_).
amount_(Event,1) :- alice_household_maintenance(_,Event,_,_).
purpose_(Event,"the home") :- alice_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- alice_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- alice_household_maintenance(_,Event,_,End_day).
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",25561).
start_("gross income","2017-12-31").

% Test
:- tax("Alice",2017,2574).
:- halt.
