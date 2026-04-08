% Text
% In 2017, Alice's gross income was $326332. Alice and Bob have been married since Feb 3rd, 2017, and have had the same principal place of abode since 2015. Alice was born March 2nd, 1950 and Bob was born March 3rd, 1955. Alice and Bob file separately in 2017. Bob has no gross income that year. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $116066

% Facts
:- [statutes/prolog/init].
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2017-12-31").
amount_("gross income",326332).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2017-02-03").
birth_("Alice was born").
agent_("Alice was born","Alice").
start_("Alice was born","1950-03-02").
end_("Alice was born","1950-03-02").
birth_("Bob was born").
agent_("Bob was born","Bob").
start_("Bob was born","1955-03-03").
end_("Bob was born","1955-03-03").
residence_("principal place of abode").
agent_("principal place of abode","Alice").
agent_("principal place of abode","Bob").
patient_("principal place of abode","the same principal place of abode").
start_("principal place of abode","2015-01-01").

% Test
:- tax("Alice",2017,116066).
:- halt.
