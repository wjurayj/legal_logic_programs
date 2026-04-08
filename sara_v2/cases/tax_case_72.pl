% Text
% Bob is Alice's father. Alice has paid $2561 to Bob for work done from Feb 1st, 2013 to Sep 2nd, 2013, in Baltimore, Maryland, USA. Alice's gross income in 2013 is $42384. Alice takes the standard deduction in 2013.

% Question
% How much tax does Alice have to pay in 2013? $7595

% Facts
:- [statutes/prolog/init].
father_("father").
agent_("father","Bob").
patient_("father","Alice").
service_("work").
patient_("work","Alice").
agent_("work","Bob").
start_("work","2013-02-01").
end_("work","2013-09-02").
location_("work","Baltimore").
location_("work","Maryland").
location_("work","USA").
payment_("paid").
agent_("paid","Alice").
patient_("paid","Bob").
start_("paid","2013-09-02").
purpose_("paid","work").
amount_("paid",2561).
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",42384).
start_("gross income","2013-12-31").

% Test
:- tax("Alice",2013,7595).
:- halt.
