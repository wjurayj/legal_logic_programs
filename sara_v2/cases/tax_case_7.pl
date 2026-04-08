% Text
% Alice and Bob got married on Feb 3rd, 2013. Alice died on July 9th, 2014. Alice was a nonresident alien. From 2004 to 2019, Bob furnished the costs of maintaining the home where he and his father Charlie lived during that time. Charlie had no income from 2015 to 2019. Bob's gross income in 2015 was $678323. Bob takes the standard deduction in 2015.

% Question
% How much tax does Bob have to pay in 2015? $245359

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2013-02-03").
death_("died").
agent_("died","Alice").
start_("died","2014-07-09").
nonresident_alien_("a nonresident alien").
agent_("a nonresident alien","Alice").
father_("father").
patient_("father","Charlie").
agent_("father","Bob").
residence_("lived").
agent_("lived","Charlie").
agent_("lived","Bob").
patient_("lived","the home").
start_("lived","2004-01-01").
end_("lived","2019-12-31").
bob_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2004,2019,Year),
    atom_concat("furnished the costs ",Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,"Bob") :- bob_household_maintenance(_,Event,_,_).
amount_(Event,1) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,"the home") :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).
income_("gross income").
agent_("gross income","Bob").
amount_("gross income",678323).
start_("gross income","2015-12-31").

% Test
:- tax("Bob",2015,245359).
:- halt.
