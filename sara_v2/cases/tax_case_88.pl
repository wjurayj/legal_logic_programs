% Text
% Alice and Bob got married on Sep 22nd, 2005. Their son Charlie was born Jan 10th, 2002. Bob passed away at the end of 2010. In 2011, Alice paid for her and Charlie's housing, a house that they shared. In 2011, Alice's gross income was $25561 and she took the standard deduction.

% Question
% How much tax does Alice have to pay in 2011? $2334

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2005-09-22").
son_("son").
agent_("son","Charlie").
patient_("son","Alice").
patient_("son","Bob").
start_("son","2002-01-10").
death_("passed away").
agent_("passed away","Bob").
start_("passed away","2010-12-31").
residence_("a house that they shared").
agent_("a house that they shared","Alice").
agent_("a house that they shared","Charlie").
patient_("a house that they shared","a house").
start_("a house that they shared","2011-01-01").
end_("a house that they shared","2011-12-31").
payment_("paid").
agent_("paid","Alice").
amount_("paid",1).
start_("paid","2011-01-01").
purpose_("paid","a house").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",25561).
start_("gross income","2011-12-31").

% Test
:- tax("Alice",2011,2334).
:- halt.
