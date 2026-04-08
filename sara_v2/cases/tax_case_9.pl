% Text
% Alice and Bob got married on April 5th, 2012. Alice and Bob have a son, Charlie, who was born on September 16th, 2017. Alice and Charlie live in a home for which Alice furnished 40% of the maintenance costs, and Bob the remaining 60%, since September 16th, 2017. Alice and Bob file jointly from 2017 to 2019. Alice and Bob's gross incomes in 2018 were $36991 and $41990 respectively. Alice and Bob take the standard deduction. From 2017 to 2019, Bob lived separately.

% Question
% How much tax does Alice have to pay in 2018? $10598

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2012-04-05").
son_("son").
agent_("son","Charlie").
patient_("son","Bob").
patient_("son","Alice").
start_("son","2017-09-16").
residence_("live").
agent_("live","Alice").
agent_("live","Charlie").
patient_("live","a home").
start_("live","2017-09-16").
bob_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2017,2117,Year),
    atom_concat("Bob the remaining 60% ",Year,Event),
    (((Year==2017)->(Start_day="2017-09-16"));first_day_year(Year,Start_day)),
    last_day_year(Year,End_day).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,"Bob") :- bob_household_maintenance(_,Event,_,_).
amount_(Event,60) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,"live") :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).
alice_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2017,2117,Year),
    atom_concat("Alice furnished 40% of the maintenance costs ",Year,Event),
    (((Year==2017)->(Start_day="2017-09-16"));first_day_year(Year,Start_day)),
    last_day_year(Year,End_day).
payment_(Event) :- alice_household_maintenance(_,Event,_,_).
agent_(Event,"Alice") :- alice_household_maintenance(_,Event,_,_).
amount_(Event,40) :- alice_household_maintenance(_,Event,_,_).
purpose_(Event,"live") :- alice_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- alice_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- alice_household_maintenance(_,Event,_,End_day).
joint_return_alice_and_bob(Year,Event,Start_day,End_day) :-
    between(2017,2019,Year),
    atom_concat("file jointly ",Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
joint_return_(Event) :- joint_return_alice_and_bob(_,Event,_,_).
agent_(Event,"Alice") :- joint_return_alice_and_bob(_,Event,_,_).
agent_(Event,"Bob") :- joint_return_alice_and_bob(_,Event,_,_).
start_(Event,Day) :- joint_return_alice_and_bob(_,Event,Day,_).
end_(Event,Day) :- joint_return_alice_and_bob(_,Event,_,Day).
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",36991).
start_("Alice's gross income","2018-12-31").
income_("Bob's gross income").
agent_("Bob's gross income","Bob").
amount_("Bob's gross income",41990).
start_("Bob's gross income","2018-12-31").
residence_("lived").
agent_("lived","Bob").
patient_("lived","lived separately").
start_("lived","2017-01-01").
end_("lived","2019-12-31").

% Test
:- tax("Alice",2018,10598).
:- halt.
