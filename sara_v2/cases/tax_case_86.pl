% Text
% Bob is Alice's father. Alice has paid $45252 to Bob for work done in the year 2017.

% Question
% How much tax does Alice have to pay in 2017? $0

% Facts
:- [statutes/prolog/init].
father_("father").
agent_("father","Bob").
patient_("father","Alice").
service_("work").
patient_("work","Alice").
agent_("work","Bob").
start_("work","2017-01-01").
end_("work","2017-12-31").
payment_("paid").
agent_("paid","Alice").
patient_("paid","Bob").
start_("paid","2017-01-01").
end_("paid","2017-12-31").
purpose_("paid","work").
amount_("paid",45252).

% Test
:- tax("Alice",2017,0).
:- halt.
