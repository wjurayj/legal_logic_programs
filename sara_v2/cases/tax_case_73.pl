% Text
% Alice's and Bob's gross incomes for the year 2013 are $71879 and $11213 respectively. Alice and Bob got married on Feb 3rd, 1992. Alice and Bob have a child, Charlie, born October 9th, 2000. From 2004 to 2019, Bob furnished 40% of the costs of maintaining the home where he and Charlie lived during that time, and Alice furnished the remaining costs. In 2013, Alice and Bob file jointly and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2013? $15109

% Facts
:- [statutes/prolog/init].
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",71879).
start_("Alice's gross income","2013-12-31").
income_("Bob's gross income").
agent_("Bob's gross income","Bob").
amount_("Bob's gross income",11213).
start_("Bob's gross income","2013-12-31").
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
alice_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2004,2019,Year),
    atom_concat("furnished the remaining costs ",Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- alice_household_maintenance(_,Event,_,_).
agent_(Event,"Alice") :- alice_household_maintenance(_,Event,_,_).
amount_(Event,60) :- alice_household_maintenance(_,Event,_,_).
purpose_(Event,"the home") :- alice_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- alice_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- alice_household_maintenance(_,Event,_,End_day).
joint_return_("file jointly").
agent_("file jointly","Alice").
agent_("file jointly","Bob").
start_("file jointly","2013-01-01").
end_("file jointly","2013-12-31").

% Test
:- tax("Alice",2013,15109).
:- halt.
