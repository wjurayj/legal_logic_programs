% Text
% Alice's gross income for the year 2017 is $6662, Bob's gross income is $17896. Alice and Bob got married on Feb 3rd, 1992. From 2004 to 2019, Bob furnished the costs of maintaining the home where he and Alice lived during that time. In 2017, Alice and Bob file separate returns, and they both take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $249

% Facts
:- [statutes/prolog/init].
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",6662).
start_("Alice's gross income","2017-12-31").
income_("Bob's gross income").
agent_("Bob's gross income","Bob").
amount_("Bob's gross income",17896).
start_("Bob's gross income","2017-12-31").
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1992-02-03").
residence_("lived").
agent_("lived","Alice").
agent_("lived","Bob").
patient_("lived","the home").
start_("lived","2004-01-01").
end_("lived","2019-12-31").
bob_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2015,2019,Year),
    atom_concat("furnished ",Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,"Bob") :- bob_household_maintenance(_,Event,_,_).
amount_(Event,1) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,"the home") :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).

% Test
:- tax("Alice",2017,249).
:- halt.
