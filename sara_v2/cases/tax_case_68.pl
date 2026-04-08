% Text
% Alice has paid $3200 to Bob for domestic service done from Feb 1st, 2017 to Sep 2nd, 2017. In 2018, Bob has paid $4500 to Alice for work done from Apr 1st, 2017 to Sep 2nd, 2018. Alice was otherwise paid $113209 in 2018.

% Question
% How much tax does Alice have to pay in 2018? $28292

% Facts
:- [statutes/prolog/init].
service_("domestic service").
patient_("domestic service","Alice").
agent_("domestic service","Bob").
start_("domestic service","2017-02-01").
end_("domestic service","2017-09-02").
purpose_("domestic service","domestic service").
payment_("Alice has paid").
agent_("Alice has paid","Alice").
patient_("Alice has paid","Bob").
start_("Alice has paid","2019-09-02").
purpose_("Alice has paid","domestic service").
amount_("Alice has paid",3200).
service_("work").
patient_("work","Bob").
agent_("work","Alice").
start_("work","2017-02-01").
end_("work","2017-09-02").
payment_("Bob has paid").
agent_("Bob has paid","Bob").
patient_("Bob has paid","Alice").
start_("Bob has paid","2018-09-02").
end_("Bob has paid","2018-09-02").
purpose_("Bob has paid","work").
amount_("Bob has paid",4500).
payment_("Alice was otherwise paid").
patient_("Alice was otherwise paid","Alice").
start_("Alice was otherwise paid","2018-12-31").
amount_("Alice was otherwise paid",113209).

% Test
:- tax("Alice",2018,28292).
:- halt.
