% Text
% Alice and Bob got married on November 23rd, 1994. Their son Charlie was born on July 5th, 2000. Bob died on March 15th, 2015. In 2017, Alice and Charlie lived in a house maintained by Alice. Alice's gross income for the year 2017 is $95129. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $19039

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1994-11-23").
son_("son").
agent_("son","Charlie").
patient_("son","Alice").
patient_("son","Bob").
start_("son","2000-07-05").
death_("died").
agent_("died","Bob").
start_("died","2015-03-15").
residence_("lived").
agent_("lived","Alice").
agent_("lived","Charlie").
patient_("lived","a house").
start_("lived","2017-01-01").
end_("lived","2017-12-31").
payment_("maintained").
agent_("maintained","Alice").
amount_("maintained",1).
purpose_("maintained","a house").
start_("maintained","2017-12-31").
income_("income").
agent_("income","Alice").
start_("income","2017-12-31").
amount_("income",95129).

% Test
:- tax("Alice",2017,19039).
:- halt.
