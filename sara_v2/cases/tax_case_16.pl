% Text
% In 2017, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2017. Bob had no income in 2017. In 2017, Alice and Bob file separately, and Alice takes the standard deduction. Alice and Bob have the same principal place of abode in 2017.

% Question
% How much tax does Alice have to pay in 2017? $4938

% Facts
:- [statutes/prolog/init].
payment_("paid").
patient_("paid","Alice").
start_("paid","2017-12-31").
amount_("paid",33200).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2017-02-03").
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2012-04-05").
residence_("have the same principal place of abode").
agent_("have the same principal place of abode","Alice").
agent_("have the same principal place of abode","Bob").
patient_("have the same principal place of abode","principal place of abode").
start_("have the same principal place of abode","2017-01-01").
end_("have the same principal place of abode","2017-12-31").

% Test
:- tax("Alice",2017,4938).
:- halt.
