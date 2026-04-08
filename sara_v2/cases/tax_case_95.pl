% Text
% Alice and Bob got married on Aug 6th, 2010. Their son Charlie was born February 2nd, 2012. Alice and Bob were legally separated under a decree of divorce on March 2nd, 2015. In 2017, Alice and Charlie live in a house maintained by Alice. Alice's gross income for the year 2017 is $9560. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $174

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2010-08-06").
son_("son").
agent_("son","Charlie").
patient_("son","Alice").
patient_("son","Bob").
start_("son","2012-02-02").
legal_separation_("were legally separated").
patient_("were legally separated","married").
agent_("were legally separated","decree of divorce").
start_("were legally separated","2015-03-02").
residence_("live").
agent_("live","Alice").
agent_("live","Charlie").
patient_("live","a house").
start_("live","2017-01-01").
end_("live","2017-12-31").
payment_("maintained").
agent_("maintained","Alice").
amount_("maintained",1).
start_("maintained","2017-01-01").
purpose_("maintained","a house").
income_("income").
agent_("income","Alice").
start_("income","2017-12-31").
amount_("income",9560).

% Test
:- tax("Alice",2017,174).
:- halt.
