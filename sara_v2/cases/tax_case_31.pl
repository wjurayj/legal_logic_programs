% Text
% In 2017, Alice was paid $39212, and Bob had no income. Alice and Bob have been married since Feb 3rd, 2017. Alice and Bob file separately in 2017.

% Question
% How much tax does Alice have to pay in 2017? $6621

% Facts
:- [statutes/prolog/init].
payment_("paid").
patient_("paid","Alice").
start_("paid","2017-12-31").
amount_("paid",39212).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2017-02-03").

% Test
:- tax("Alice",2017,6621).
:- halt.
