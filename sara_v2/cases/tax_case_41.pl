% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice was a nonresident alien until July 9th, 2014. Bob died September 16th, 2017. Alice's gross income in 2013 was $71414. Bob's gross income in 2013 was $56404. Alice files separately and takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2013? $17783

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1992-02-03").
nonresident_alien_("a nonresident alien").
agent_("a nonresident alien","Alice").
end_("a nonresident alien","2014-07-09").
marriage_("married").
death_("died").
agent_("died","Bob").
start_("died","2017-09-16").
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",71414).
start_("Alice's gross income","2013-12-31").
income_("Bob's gross income").
agent_("Bob's gross income","Bob").
amount_("Bob's gross income",56404).
start_("Bob's gross income","2013-12-31").

% Test
:- tax("Alice",2013,17783).
:- halt.
