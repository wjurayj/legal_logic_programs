% Text
% Alice's gross income for the year 2017 is $22895. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $2684

% Facts
:- [statutes/prolog/init].
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2017-12-31").
amount_("gross income",22895).

% Test
:- tax("Alice",2017,2684).
:- halt.
