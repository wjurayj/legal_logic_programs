% Text
% Alice has paid $3200 to her father Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017, in Baltimore, Maryland, USA. Alice and Charlie got married on April 5th, 2012. Alice and Charlie were legally separated under a decree of divorce on September 16th, 2017. Alice's gross income in 2017 was $756420. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $279126

% Facts
:- [statutes/prolog/init].
service_("work").
patient_("work","Alice").
agent_("work","Bob").
start_("work","2017-02-01").
end_("work","2017-09-02").
location_("work","Baltimore").
location_("work","Maryland").
location_("work","USA").
payment_("paid").
agent_("paid","Alice").
patient_("paid","Bob").
start_("paid","2017-09-02").
purpose_("paid","work").
amount_("paid",3200).
father_("father").
agent_("father","Bob").
patient_("father","Alice").
marriage_("married").
agent_("married","Alice").
agent_("married","Charlie").
start_("married","2012-04-05").
legal_separation_("legally separated").
patient_("legally separated","married").
agent_("legally separated","decree of divorce").
start_("legally separated","2017-09-16").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",756420).
start_("gross income","2017-12-31").

% Test
:- tax("Alice",2017,279126).
:- halt.
