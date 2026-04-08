% Text
% Alice and Bob were married from Feb 3rd, 1997 to Oct 30th, 2001. Alice's gross income for the year 2014 is $718791 and she takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2014? $264225

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1997-02-03").
end_("married","2001-10-31").
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2014-12-31").
amount_("gross income",718791).

% Test
:- tax("Alice",2014,264225).
:- halt.
