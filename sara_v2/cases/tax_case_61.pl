% Text
% Bob, Alice's father, has the same principal place of abode as Alice since 2012, and has had no income since. Alice's gross income for the year 2015 is $102268. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2015? $25055

% Facts
:- [statutes/prolog/init].
father_("father").
agent_("father","Bob").
patient_("father","Alice").
residence_("the same principal place of abode").
agent_("the same principal place of abode","Alice").
agent_("the same principal place of abode","Bob").
patient_("the same principal place of abode","the same principal place of abode").
start_("the same principal place of abode","2012-01-01").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",102268).
start_("gross income","2015-01-01").
end_("gross income","2015-12-31").

% Test
:- tax("Alice",2015,25055).
:- halt.
