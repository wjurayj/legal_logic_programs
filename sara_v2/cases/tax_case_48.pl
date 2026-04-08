% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice and Bob have a child, Charlie, born October 9th, 2000. Alice died on July 9th, 2014. From 2004 to 2018, Bob furnished the costs of maintaining the home where he and Charlie lived during that time. Charlie married Dan on Feb 14th, 2018, and they file a joint return that same year. Bob's gross income in 2018 was $132268. Bob takes the standard deduction.

% Question
% How much tax does Bob have to pay in 2018? $33068

% Facts
:- [statutes/prolog/init].
marriage_("Alice and Bob got married").
agent_("Alice and Bob got married","Alice").
agent_("Alice and Bob got married","Bob").
start_("Alice and Bob got married","1992-02-03").
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
    between(2004,2018,Year),
    atom_concat("furnished the costs ",Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,"Bob") :- bob_household_maintenance(_,Event,_,_).
amount_(Event,1) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,"the home") :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).
marriage_("Charlie married Dan").
agent_("Charlie married Dan","Dan").
agent_("Charlie married Dan","Charlie").
start_("Charlie married Dan","2018-02-14").
joint_return_("file a joint return").
agent_("file a joint return","Charlie").
agent_("file a joint return","Dan").
start_("file a joint return","2018-01-01").
end_("file a joint return","2018-12-31").
income_("gross income").
agent_("gross income","Bob").
amount_("gross income",132268).
start_("gross income","2018-12-31").

% Test
:- tax("Bob",2018,33068).
:- halt.
