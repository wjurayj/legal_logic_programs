% Text
% Alice, born Jun 7, 1964, has a son, Bob, born Feb 7, 1988. Bob has a son, Charlie, born Jun 29, 2014. Alice, Bob and Charlie have the same principal place of abode in 2015. Bob's gross income in 2015 is $43591. Bob takes the standard deduction.

% Question
% How much tax does Bob have to pay in 2015? $6812

% Facts
:- [statutes/prolog/init].
birth_("Alice, born Jun 7, 1964").
agent_("Alice, born Jun 7, 1964","Alice").
start_("Alice, born Jun 7, 1964","1964-06-07").
son_("Alice, born Jun 7, 1964, has a son").
agent_("Alice, born Jun 7, 1964, has a son","Bob").
patient_("Alice, born Jun 7, 1964, has a son","Alice").
start_("Alice, born Jun 7, 1964, has a son","1988-02-07").
residence_("principal place of abode").
agent_("principal place of abode","Alice").
agent_("principal place of abode","Bob").
agent_("principal place of abode","Charlie").
patient_("principal place of abode","principal place of abode").
start_("principal place of abode","2015-01-01").
end_("principal place of abode","2015-12-31").
son_("Bob has a son").
agent_("Bob has a son","Charlie").
patient_("Bob has a son","Bob").
start_("Bob has a son","2014-06-29").
income_("gross income").
agent_("gross income","Bob").
amount_("gross income",43591).
start_("gross income","2015-12-31").

% Test
:- tax("Bob",2015,6812).
:- halt.
