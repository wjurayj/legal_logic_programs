% Text
% Alice has paid wages of $53200 to Bob for domestic service done from Feb 1st, 2017 to Sep 2nd, 2017. Alice's gross income in 2017 was $921324. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $344848

% Facts
:- [statutes/prolog/init].
service_("domestic service").
patient_("domestic service","Alice").
agent_("domestic service","Bob").
start_("domestic service","2017-02-01").
end_("domestic service","2017-09-02").
purpose_("domestic service","domestic service").
payment_("paid").
agent_("paid","Alice").
patient_("paid","Bob").
start_("paid","2017-09-02").
purpose_("paid","domestic service").
amount_("paid",53200).
income_("gross income").
start_("gross income","2017-12-31").
amount_("gross income",921324).
agent_("gross income","Alice").

% Test
:- tax("Alice",2017,344848).
:- halt.
