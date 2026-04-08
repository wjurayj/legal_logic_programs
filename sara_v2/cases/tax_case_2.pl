% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice and Bob have a child, Charlie, born October 9th, 2000. Alice died on July 9th, 2014. From 2004 to 2019, Bob furnished 40% of the costs of maintaining the home where he and Charlie lived during that time. In 2013, Alice and Bob filed jointly, and took the standard deduction. In 2013, Alice earned $65400 and Bob earned $56400.

% Question
% How much tax does Alice have to pay in 2013? $26567

% Facts
:- [statutes/prolog/init].
joint_return_("filed jointly").
agent_("filed jointly","Alice").
agent_("filed jointly","Bob").
start_("filed jointly","2013-01-01").
end_("filed jointly","2013-12-31").
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1992-02-03").
death_("died").
agent_("died","Alice").
start_("died","2014-07-09").
end_("died","2014-07-09").
son_("child").
agent_("child","Charlie").
patient_("child","Alice").
patient_("child","Bob").
start_("child","2000-10-09").
residence_("lived").
agent_("lived","Charlie").
agent_("lived","Bob").
patient_("lived","the home").
start_("lived","2004-01-01").
end_("lived","2019-12-31").
bob_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2004,2019,Year),
    atom_concat("furnished 40% of the costs ",Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,"Bob") :- bob_household_maintenance(_,Event,_,_).
amount_(Event,40) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,"the home") :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).
someone_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2004,2019,Year),
    atom_concat("maintaining the home ",Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- someone_household_maintenance(_,Event,_,_).
agent_(Event,"someone") :- someone_household_maintenance(_,Event,_,_).
amount_(Event,60) :- someone_household_maintenance(_,Event,_,_).
purpose_(Event,"the home") :- someone_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- someone_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- someone_household_maintenance(_,Event,_,End_day).
income_("Alice earned").
agent_("Alice earned","Alice").
amount_("Alice earned",65400).
start_("Alice earned","2013-12-31").
income_("Bob earned").
agent_("Bob earned","Bob").
amount_("Bob earned",56400).
start_("Bob earned","2013-12-31").

% Test
:- tax("Alice",2013,26567).
:- halt.
