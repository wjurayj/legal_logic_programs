% Text
% In 2017, Alice was paid $36266. Alice and Bob have been married since Feb 3rd, 2017. Alice was born March 2nd, 1950 and Bob was born March 3rd, 1951. Bob had no income in 2017. Alice and Bob file separately in 2017. Alice takes the standard deduction. Alice and Bob have the same principal place of abode in 2017.

% Question
% How much tax does Alice have to pay in 2017? $5460

% Facts
:- [statutes/prolog/init].
payment_("paid").
patient_("paid","Alice").
start_("paid","2017-12-31").
amount_("paid",36266).
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
start_("Bob was born","1951-03-03").
end_("Bob was born","1951-03-03").
residence_("principal place of abode").
agent_("principal place of abode","Alice").
patient_("principal place of abode","principal place of abode").
start_("principal place of abode","2017-01-01").
end_("principal place of abode","2017-12-31").
residence_("principal place of abode").
agent_("principal place of abode","Bob").
patient_("principal place of abode","principal place of abode").
start_("principal place of abode","2017-01-01").
end_("principal place of abode","2017-12-31").

% Test
:- tax("Alice",2017,5460).
:- halt.
