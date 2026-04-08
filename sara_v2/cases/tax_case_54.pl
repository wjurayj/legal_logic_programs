% Text
% Alice and Bob got married on Feb 3rd, 1998, and have a son Charlie, born April 1st, 1999. Bob died on Jan 1st, 2017. In 2019, Charlie lives at the house that Alice maintains as her principal place of abode. Alice's gross income for the year 2019 is $236422. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2019? $62000

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1998-02-03").
son_("son").
agent_("son","Charlie").
patient_("son","Alice").
patient_("son","Bob").
start_("son","1999-04-01").
death_("died").
agent_("died","Bob").
start_("died","2017-01-01").
residence_("lives").
agent_("lives","Charlie").
patient_("lives","the house").
start_("lives","2019-01-01").
end_("lives","2019-12-31").
payment_("maintains").
agent_("maintains","Alice").
amount_("maintains",1).
start_("maintains","2019-01-01").
purpose_("maintains","the house").
residence_("principal place of abode").
agent_("principal place of abode","Alice").
patient_("principal place of abode","the house").
start_("principal place of abode","2019-01-01").
end_("principal place of abode","2019-12-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",236422).
start_("gross income","2019-12-31").

% Test
:- tax("Alice",2019,62000).
:- halt.
