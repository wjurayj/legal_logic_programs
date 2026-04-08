% Text
% Alice married Bob on May 29th, 2008. Their son Charlie was born October 4th, 2004. Bob died October 22nd, 2016. Alice's gross income for the year 2016 was $113580. In 2017, Alice's gross income was $567192. In 2017, Alice and Charlie lived in a house maintained by Alice. That same year, Alice is allowed a deduction of $59850 for donating cash to a charity.

% Question
% How much tax does Alice have to pay in 2017? $180610

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2008-05-29").
son_("son").
agent_("son","Charlie").
patient_("son","Alice").
patient_("son","Bob").
start_("son","2004-10-04").
death_("died").
agent_("died","Bob").
start_("died","2016-10-22").
income_("Alice's gross income for the year 2016").
agent_("Alice's gross income for the year 2016","Alice").
start_("Alice's gross income for the year 2016","2016-12-31").
amount_("Alice's gross income for the year 2016",113580).
income_("In 2017, Alice's gross income").
agent_("In 2017, Alice's gross income","Alice").
start_("In 2017, Alice's gross income","2017-12-31").
amount_("In 2017, Alice's gross income",567192).
residence_("lived").
agent_("lived","Alice").
agent_("lived","Charlie").
patient_("lived","a house").
start_("lived","2017-01-01").
end_("lived","2017-12-31").
payment_("maintained").
agent_("maintained","Alice").
amount_("maintained",1).
start_("maintained","2017-01-01").
purpose_("maintained","a house").
deduction_("a deduction").
agent_("a deduction","Alice").
amount_("a deduction",59850).
start_("a deduction","2017-12-31").

% Test
:- tax("Alice",2017,180610).
:- halt.
