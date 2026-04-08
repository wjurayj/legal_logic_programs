% Text
% Alice has been married since April 4th, 2015. Alice files a joint return with her spouse for 2016. Alice's and her spouse's gross income for the year 2016 is $164612. Alice has paid $4525 to Bob for work done in the year 2016. In 2016, Alice has also paid $9832 into a retirement fund for Bob, and $5322 into health insurance for Charlie, who is Alice's father and has retired in 2016. Charlie had no income in 2016. Alice and her spouse take the standard deduction.

% Question
% How much tax does Alice have to pay in 2016? $40741

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","her spouse").
start_("married","2015-04-04").
joint_return_("files a joint return").
agent_("files a joint return","Alice").
agent_("files a joint return","her spouse").
start_("files a joint return","2016-01-01").
end_("files a joint return","2016-12-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",164612).
start_("gross income","2016-12-31").
service_("work").
patient_("work","Alice").
agent_("work","Bob").
start_("work","2016-01-01").
end_("work","2016-12-31").
payment_("Alice has paid").
agent_("Alice has paid","Alice").
patient_("Alice has paid","Bob").
start_("Alice has paid","2016-01-01").
end_("Alice has paid","2016-12-31").
purpose_("Alice has paid","work").
amount_("Alice has paid",4525).
payment_("$9832 into a retirement fund").
agent_("$9832 into a retirement fund","Alice").
patient_("$9832 into a retirement fund","retirement fund").
purpose_("$9832 into a retirement fund","make provisions for employees in case of retirement").
plan_("retirement fund").
beneficiary_("$9832 into a retirement","Bob").
start_("$9832 into a retirement fund","2016-01-01").
end_("$9832 into a retirement fund","2016-12-31").
amount_("$9832 into a retirement fund",9832).
payment_("$5322 into health insurance").
agent_("$5322 into health insurance","Alice").
patient_("$5322 into health insurance","health insurance").
plan_("health insurance").
purpose_("$5322 into health insurance","make provisions for employees in case of sickness").
beneficiary_("$5322 into health insurance","Charlie").
start_("$5322 into health insurance","2016-01-01").
end_("$5322 into health insurance","2016-12-31").
amount_("$5322 into health insurance",5322).
father_("father").
agent_("father","Charlie").
patient_("father","Alice").
retirement_("retired").
agent_("retired","Charlie").
start_("retired","2016-01-01").

% Test
:- tax("Alice",2016,40741).
:- halt.
