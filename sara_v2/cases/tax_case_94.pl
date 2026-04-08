% Text
% Alice's gross income for the year 2010 is $210204. Alice has paid $45252 to Bob for work done in the year 2010. In 2010, Alice has also paid $9832 into a retirement fund for Bob, and $5322 into health insurance for Charlie, who is Alice's father and has retired in 2009. Bob has no income in 2010. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2010? $63345

% Facts
:- [statutes/prolog/init].
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",210204).
start_("Alice's gross income","2010-12-31").
service_("work").
patient_("work","Alice").
agent_("work","Bob").
start_("work","2010-01-01").
end_("work","2010-12-31").
payment_("Alice has paid $45252 to Bob").
agent_("Alice has paid $45252 to Bob","Alice").
patient_("Alice has paid $45252 to Bob","Bob").
start_("Alice has paid $45252 to Bob","2010-01-01").
end_("Alice has paid $45252 to Bob","2010-12-31").
purpose_("Alice has paid $45252 to Bob","work").
amount_("Alice has paid $45252 to Bob",45252).
payment_("$9832 into a retirement fund").
agent_("$9832 into a retirement fund","Alice").
patient_("$9832 into a retirement fund","retirement fund").
purpose_("$9832 into a retirement fund","make provisions for employees in case of retirement").
plan_("retirement fund").
beneficiary_("$9832 into a retirement fund","Bob").
start_("$9832 into a retirement fund","2010-01-01").
end_("$9832 into a retirement fund","2010-12-31").
amount_("$9832 into a retirement fund",9832).
payment_("$5322 into health insurance").
agent_("$5322 into health insurance","Alice").
patient_("$5322 into health insurance","health insurance").
plan_("health insurance").
purpose_("$5322 into health insurance","make provisions for employees in case of sickness").
beneficiary_("$5322 into health insurance","Charlie").
start_("$5322 into health insurance","2010-01-01").
end_("$5322 into health insurance","2010-12-31").
amount_("$5322 into health insurance",5322).
father_("father").
agent_("father","Charlie").
patient_("father","Alice").
retirement_("retired").
agent_("retired","Charlie").
start_("retired","2009-01-01").

% Test
:- tax("Alice",2010,63345).
:- halt.
