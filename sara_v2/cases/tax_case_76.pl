% Text
% Alice, born Sep 4th, 1950, has a son, Bob, who was born January 31st, 1984. Alice and Bob share the same principal place of abode since then, which Alice maintains. Alice's gross income for the year 1997 is $172980. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 1997? $46734

% Facts
:- [statutes/prolog/init].
birth_("Alice, born Sep 4th, 1950").
agent_("Alice, born Sep 4th, 1950","Alice").
start_("Alice, born Sep 4th, 1950","1950-11-04").
son_("son").
agent_("son","Bob").
patient_("son","Alice").
start_("son","1984-01-31").
residence_("share the same principal place of abode").
agent_("share the same principal place of abode","Alice").
agent_("share the same principal place of abode","Bob").
patient_("share the same principal place of abode","the same principal place of abode").
start_("share the same principal place of abode","1984-01-31").
payment_("maintains").
agent_("maintains","Alice").
amount_("maintains",1).
start_("maintains",Day) :- between(1984,2084,Year),
    first_day_year(Year,Day).
purpose_("maintains","the same principal place of abode").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",172980).
start_("gross income","1997-12-31").

% Test
:- tax("Alice",1997,46734).
:- halt.
