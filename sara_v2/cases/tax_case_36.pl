% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice and Bob have a child, Charlie, born October 9th, 2000. From 2004 to 2019, Bob furnished the costs of maintaining the home where he and Charlie lived during that time. From 2015 to 2018, Alice had a different principal place of abode. In 2017, Alice was paid $33200, and Bob's income was $32311. Alice was born March 2nd, 1950 and Bob was born March 3rd, 1955. In 2017, Alice and Bob file jointly and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $10018

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1992-02-03").
son_("child").
agent_("child","Charlie").
patient_("child","Alice").
patient_("child","Bob").
start_("child","2000-10-09").
residence_("lived").
agent_("lived","Bob").
agent_("lived","Charlie").
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
residence_("principal place of abode").
agent_("principal place of abode","Bob").
patient_("principal place of abode","a different principal place of abode").
start_("principal place of abode","2015-01-01").
end_("principal place of abode","2018-12-31").
payment_("paid").
patient_("paid","Alice").
start_("paid","2017-12-31").
amount_("paid",33200).
income_("income").
agent_("income","Bob").
start_("income","2017-12-31").
amount_("income",32311).
birth_("Alice was born").
agent_("Alice was born","Alice").
start_("Alice was born","1950-03-02").
end_("Alice was born","1950-03-02").
birth_("Bob was born").
agent_("Bob was born","Bob").
start_("Bob was born","1955-03-03").
end_("Bob was born","1955-03-03").
joint_return_("file jointly").
agent_("file jointly","Alice").
agent_("file jointly","Bob").
start_("file jointly","2017-01-01").
end_("file jointly","2017-12-31").

% Test
:- tax("Alice",2017,10018).
:- halt.
