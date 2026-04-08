% Text
% Alice has a son, Bob. From September 1st, 2015 to November 3rd, 2019, Alice and Bob lived in the same home, maintained by Alice. Bob was born on September 1st, 2015. Alice's gross income for the year 2017 is $545547. Alice's gross income for the year 2018 is $545947. Alice's gross income for the year 2019 is $545927.

% Question
% How much tax does Alice have to pay in 2018? $187552

% Facts
:- [statutes/prolog/init].
son_("son").
agent_("son","Bob").
patient_("son","Alice").
start_("son","2015-09-01").
residence_("lived").
agent_("lived","Alice").
agent_("lived","Bob").
patient_("lived","the same home").
start_("lived","2015-09-01").
end_("lived","2019-11-03").
payment_("maintained").
agent_("maintained","Alice").
purpose_("maintained","the same home").
start_("maintained",Day) :- between(2015,2019,Year), last_day_year(Year,Day).
amount_("maintained",1).
income_("Alice's gross income for the year 2017").
agent_("Alice's gross income for the year 2017","Alice").
amount_("Alice's gross income for the year 2017",545547).
start_("Alice's gross income for the year 2017","2017-12-31").
income_("Alice's gross income for the year 2018").
agent_("Alice's gross income for the year 2018","Alice").
amount_("Alice's gross income for the year 2018",545947).
start_("Alice's gross income for the year 2018","2018-12-31").
income_("Alice's gross income for the year 2019").
agent_("Alice's gross income for the year 2019","Alice").
amount_("Alice's gross income for the year 2019",545927).
start_("Alice's gross income for the year 2019","2019-12-31").

% Test
:- tax("Alice",2018,187552).
:- halt.
