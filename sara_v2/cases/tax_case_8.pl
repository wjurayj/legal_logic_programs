% Text
% Alice and Bob got married on Sep 12th, 1998. Their son Charlie was born October 1st, 2013. Bob passed away March 2nd, 2015. In 2017, Alice and Charlie live in a house maintained by Alice. Alice's gross income for the year 2017 was $70117. Alice takes the standard deduction in 2017.

% Question
% How much tax does Alice have to pay in 2017? $12036

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1998-09-12").
son_("son").
agent_("son","Charlie").
patient_("son","Alice").
patient_("son","Bob").
start_("son","2013-10-01").
death_("passed away").
agent_("passed away","Bob").
start_("passed away","2015-03-02").
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
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",70117).
start_("gross income","2017-12-31").

% Test
:- tax("Alice",2017,12036).
:- halt.
