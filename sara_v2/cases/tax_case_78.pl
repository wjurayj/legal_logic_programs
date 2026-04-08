% Text
% Alice and Bob got married on April 5th, 2012. Alice and Bob have a son, Charlie, who was born on September 16th, 2017. Alice and Charlie live in a home maintained by Alice since September 16th, 2017. Alice's gross income in 2019 is $73124. Alice and Bob file separate returns. Alice takes the standard deduction. In 2019, Bob has a different principal place of abode than Alice and Charlie.

% Question
% How much tax does Alice have to pay in 2019? $14470

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
alice_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2017,2117,Year),
    atom_concat("maintained ",Year,Event),
    (((Year==2017)->(Start_day="2017-09-16"));first_day_year(Year,Start_day)),
    last_day_year(Year,End_day).
payment_(Event) :- alice_household_maintenance(_,Event,_,_).
agent_(Event,"Alice") :- alice_household_maintenance(_,Event,_,_).
amount_(Event,1) :- alice_household_maintenance(_,Event,_,_).
purpose_(Event,"a home") :- alice_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- alice_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- alice_household_maintenance(_,Event,_,End_day).
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",73124).
start_("gross income","2019-12-31").
residence_("principal place of abode").
agent_("principal place of abode","Bob").
patient_("principal place of abode","a different principal place of abode").
start_("principal place of abode","2019-01-01").
end_("principal place of abode","2019-12-31").

% Test
:- tax("Alice",2019,14470).
:- halt.
