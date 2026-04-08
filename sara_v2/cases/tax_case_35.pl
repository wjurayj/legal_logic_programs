% Text
% Alice's gross income for the year 2017 is $22895. In 2017, Alice takes the standard deduction. Alice has a son, Bob, who has the same principal place of abode as her in 2017 and is not married.

% Question
% How much tax does Alice have to pay in 2017? $2384

% Facts
:- [statutes/prolog/init].
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2017-12-31").
amount_("gross income",22895).
son_("son").
agent_("son","Bob").
patient_("son","Alice").
residence_("principal place of abode").
agent_("principal place of abode","Alice").
patient_("principal place of abode","Bob").
patient_("principal place of abode","principal place of abode").
start_("principal place of abode","2017-01-01").

% Test
:- tax("Alice",2017,2384).
:- halt.
