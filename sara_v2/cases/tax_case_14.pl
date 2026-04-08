% Text
% In 2017, Alice's gross income was $44215. Alice and Bob have been married since Oct 10th, 2017. Alice and Bob file separately. Alice has paid $3200 in cash to Bob for agricultural labor done from Feb 1st, 2017 to Sep 2nd, 2017. Alice takes the standard deduction. Alice and Bob live separately in 2017.

% Question
% How much tax does Alice have to pay in 2017? $8582

% Facts
:- [statutes/prolog/init].
income_("income").
agent_("income","Alice").
start_("income","2017-12-31").
amount_("income",44215).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2017-10-10").
service_("agricultural labor").
patient_("agricultural labor","Alice").
agent_("agricultural labor","Bob").
start_("agricultural labor","2017-02-01").
end_("agricultural labor","2017-09-02").
purpose_("agricultural labor","agricultural labor").
payment_("paid").
agent_("paid","Alice").
patient_("paid","Bob").
start_("paid","2017-09-02").
purpose_("paid","agricultural labor").
amount_("paid",3200).
means_("paid","cash").
residence_("Alice lives separately").
agent_("Alice lives separately","Alice").
patient_("Alice lives separately","Alice home").
start_("Alice lives separately","2017-01-01").
end_("Alice lives separately","2017-12-31").
residence_("Bob lives separately").
agent_("Bob lives separately","Bob").
patient_("Bob lives separately","Bob home").
start_("Bob lives separately","2017-01-01").
end_("Bob lives separately","2017-12-31").

% Test
:- tax("Alice",2017,8582).
:- halt.
