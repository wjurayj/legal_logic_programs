% Text
% Alice shares a house with her father Bob since 2007. Alice pays for 75% of the costs of the house, while Charlie, her brother, pays for the remaining 25%. Alice's gross income for the year 2012 was $67285 and Charlie's was $56174. Alice is allowed itemized deductions of $17817.

% Question
% How much tax does Alice have to pay in 2012? $8883

% Facts
:- [statutes/prolog/init].
residence_("shares a house").
agent_("shares a house","Alice").
agent_("shares a house","Bob").
patient_("shares a house","a house").
start_("shares a house","2007-01-01").
father_("father").
agent_("father","Bob").
patient_("father","Alice").
payment_("pays for 75% of the costs").
agent_("pays for 75% of the costs","Alice").
amount_("pays for 75% of the costs",75).
purpose_("pays for 75% of the costs","a house").
start_("pays for 75% of the costs",Day) :- between(2007,2107,Year),
    first_day_year(Year,Day).
brother_("brother").
agent_("brother","Charlie").
patient_("brother","Alice").
payment_("pays for the remaining 25%").
agent_("pays for the remaining 25%","Charlie").
amount_("pays for the remaining 25%",25).
purpose_("pays for the remaining 25%","a house").
start_("pays for the remaining 25%",Day) :- between(2007,2107,Year),
    first_day_year(Year,Day).
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",67285).
start_("Alice's gross income","2012-12-31").
income_("Charlie's").
agent_("Charlie's","Charlie").
amount_("Charlie's",56174).
start_("Charlie's","2012-12-31").
deduction_("itemized deductions").
agent_("itemized deductions","Alice").
amount_("itemized deductions",17817).
start_("itemized deductions","2012-01-01").

% Test
:- tax("Alice",2012,8883).
:- halt.
