% Text
% Alice paid Bob for agricultural labor from Feb 1st, 2019 to November 19th, 2019, paying him $27371 in 2019. On November 25th, Bob died from a heart attack. On January 20th, 2020, Alice paid Charlie, Bob's surviving spouse, Bob's outstanding wages of $24500. In 2020, Alice's gross income was $372109. Alice receives a deduction of $25000 for donating goods to a food bank.

% Question
% How much tax does Alice have to pay in 2020? $118227

% Facts
:- [statutes/prolog/init].
service_("agricultural labor").
agent_("agricultural labor","Bob").
patient_("agricultural labor","Alice").
start_("agricultural labor","2019-02-01").
end_("agricultural labor","2019-11-19").
purpose_("agricultural labor","agricultural labor").
payment_("Alice paid Bob").
agent_("Alice paid Bob","Alice").
patient_("Alice paid Bob","Bob").
purpose_("Alice paid Bob","agricultural labor").
start_("Alice paid Bob","2019-12-31").
amount_("Alice paid Bob",27371).
death_("died").
agent_("died","Bob").
start_("died","2019-11-25").
end_("died","2019-11-25").
marriage_("spouse").
agent_("spouse","Bob").
agent_("spouse","Charlie").
payment_("Alice paid Charlie").
agent_("Alice paid Charlie","Alice").
patient_("Alice paid Charlie","Charlie").
start_("Alice paid Charlie","2020-01-20").
purpose_("Alice paid Charlie","agricultural labor").
amount_("Alice paid Charlie",24500).
payment_("income").
patient_("income","Alice").
start_("income","2020-12-31").
amount_("income",372109).
deduction_("a deduction").
agent_("a deduction","Alice").
amount_("a deduction",25000).
start_("a deduction","2020-12-31").

% Test
:- tax("Alice",2020,118227).
:- halt.
