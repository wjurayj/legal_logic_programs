% Text
% Alice's father, Bob, was paid $53249 in remuneration in 2017 for services performed for Johns Hopkins University. Alice was enrolled at Johns Hopkins University and attending classes from August 29, 2015 to May 30th, 2019. While attending classes at Johns Hopkins University, Alice lived at Bob's house, for which Bob furnished all costs. In 2017, Bob takes the standard deduction.

% Question
% How much tax does Bob have to pay in 2017? $8710

% Facts
:- [statutes/prolog/init].
father_("father").
agent_("father","Bob").
patient_("father","Alice").
payment_("paid").
agent_("paid","Johns Hopkins University").
patient_("paid","Bob").
start_("paid","2017-12-31").
purpose_("paid","services").
amount_("paid",53249).
service_("services").
patient_("services","Johns Hopkins University").
agent_("services","Bob").
start_("services","2017-01-01").
end_("services","2017-12-31").
educational_institution_("Johns Hopkins University").
agent_("Johns Hopkins University","Johns Hopkins University").
enrollment_("enrolled").
agent_("enrolled","Alice").
patient_("enrolled","Johns Hopkins University").
start_("enrolled","2015-08-29").
end_("enrolled","2019-05-30").
attending_classes_("attending classes from August 29, 2015 to May 30th, 2019").
agent_("attending classes from August 29, 2015 to May 30th, 2019","Alice").
location_("attending classes from August 29, 2015 to May 30th, 2019","Johns Hopkins University").
start_("attending classes from August 29, 2015 to May 30th, 2019","2015-08-29").
end_("attending classes from August 29, 2015 to May 30th, 2019","2019-05-30").
residence_("Bob's house").
agent_("Bob's house","Bob").
patient_("Bob's house","Bob's house").
residence_("lived").
agent_("lived","Alice").
patient_("lived","Bob's house").
start_("lived","2015-08-29").
end_("lived","2019-05-30").
bob_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2015,2019,Year),
    atom_concat("furnished ",Year,Event),
    (((Year==2015)->(Start_day="2015-08-29"));first_day_year(Year,Start_day)),
    (((Year==2019)->(End_day="2019-05-30"));last_day_year(Year,End_day)).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,"Bob") :- bob_household_maintenance(_,Event,_,_).
amount_(Event,1) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,"Bob's house") :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).

% Test
:- tax("Bob",2017,8710).
:- halt.
