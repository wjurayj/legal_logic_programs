% Text
% Bob is Alice and Charlie's father. Bob had no income in 2015. Alice's gross income in 2015 is $264215. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2015? $82819

% Facts
:- [statutes/prolog/init].
father_("father").
agent_("father","Bob").
patient_("father","Alice").
patient_("father","Charlie").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",264215).
start_("gross income","2015-12-31").

% Test
:- tax("Alice",2015,82819).
:- halt.
