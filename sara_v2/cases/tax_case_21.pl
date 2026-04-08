% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice and Bob have a child, Charlie, born October 9th, 2000. From 2004 to 2019, Bob furnished the costs of maintaining the home where Alice, Bob and Charlie lived during that time. Charlie married Dan on Feb 14th, 2018 and they file separate tax returns in 2018. Dan's principal place of abode for 2018 is different from Charlie's. Alice's gross income in 2018 was $54232, and Bob's gross income was $43245. Alice and Bob file a joint return in 2018 and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2018? $15777

% Facts
:- [statutes/prolog/init].
marriage_("Alice and Bob got married").
agent_("Alice and Bob got married","Alice").
agent_("Alice and Bob got married","Bob").
start_("Alice and Bob got married","1992-02-03").
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
residence_("Dan's principal place of abode").
agent_("Dan's principal place of abode","Dan").
patient_("Dan's principal place of abode","Dan's principal place of abode").
start_("Dan's principal place of abode","2018-01-01").
end_("Dan's principal place of abode","2018-12-31").
residence_("Charlie's").
agent_("Charlie's","Charlie").
patient_("Charlie's","Charlie's").
start_("Charlie's","2018-01-01").
end_("Charlie's","2018-12-31").
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",54232).
start_("Alice's gross income","2018-12-31").
income_("Bob's gross income").
agent_("Bob's gross income","Bob").
amount_("Bob's gross income",43245).
start_("Bob's gross income","2018-12-31").
joint_return_("file a joint return").
agent_("file a joint return","Alice").
agent_("file a joint return","Bob").
start_("file a joint return","2018-01-01").
end_("file a joint return","2018-12-31").

% Test
:- tax("Alice",2018,15777).
:- halt.
