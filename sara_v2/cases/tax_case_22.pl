% Text
% Alice has a son, Bob, who was born January 31st, 2014, and has lived at Alice's place since then. Alice's gross income for the year 2017 is $22895. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $2174

% Facts
:- [statutes/prolog/init].
son_("son").
agent_("son","Bob").
patient_("son","Alice").
start_("son","2014-01-31").
residence_("Alice's place").
agent_("Alice's place","Alice").
patient_("Alice's place","Alice's place").
residence_("lived").
agent_("lived","Bob").
patient_("lived","Alice's place").
payment_("Alice's").
agent_("Alice's","Alice").
amount_("Alice's",1).
purpose_("Alice's","Alice's place").
start_("Alice's","2017-12-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",22895).
start_("gross income","2017-12-31").

% Test
:- tax("Alice",2017,2174).
:- halt.
