% Text
% In 2017, Alice earned $133200. Bob's income in 2017 was $44311. Alice and Bob have been married since Feb 3rd, 2017. Alice has been blind since Feb 28, 2014. Alice has paid $4525 to Charlie for work done in the year 2017. In 2017, Alice has also paid $983 into a retirement fund for Charlie, and $5322 into health insurance for Charlie, both under a plan. Alice and Bob file jointly and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $45946

% Facts
:- [statutes/prolog/init].
income_("earned").
agent_("earned","Alice").
start_("earned","2017-12-31").
amount_("earned",133200).
income_("income").
agent_("income","Bob").
start_("income","2017-12-31").
amount_("income",44311).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2017-02-03").
blindness_("blind").
agent_("blind","Alice").
start_("blind","2014-02-28").
service_("work").
patient_("work","Alice").
agent_("work","Charlie").
start_("work","2017-01-01").
end_("work","2017-12-31").
payment_("Alice has paid $4525 to Charlie").
agent_("Alice has paid $4525 to Charlie","Alice").
patient_("Alice has paid $4525 to Charlie","Charlie").
start_("Alice has paid $4525 to Charlie","2017-01-01").
end_("Alice has paid $4525 to Charlie","2017-12-31").
purpose_("Alice has paid $4525 to Charlie","work").
amount_("Alice has paid $4525 to Charlie",4525).
payment_("$983 into a retirement fund").
agent_("$983 into a retirement fund","Alice").
patient_("$983 into a retirement fund","retirement fund").
purpose_("$983 into a retirement fund","work").
purpose_("retirement fund","make provisions for employees in case of retirement").
plan_("retirement fund").
beneficiary_("retirement fund","Charlie").
start_("$983 into a retirement fund","2017-01-01").
end_("$983 into a retirement fund","2017-12-31").
amount_("$983 into a retirement fund",983).
payment_("$5322 into health insurance").
agent_("$5322 into health insurance","Alice").
patient_("$5322 into health insurance","health insurance").
purpose_("$5322 into health insurance","work").
plan_("health insurance").
purpose_("health insurance","make provisions for employees in case of sickness").
beneficiary_("health insurance","Charlie").
start_("$5322 into health insurance","2017-01-01").
end_("$5322 into health insurance","2017-12-31").
amount_("$5322 into health insurance",532).
joint_return_("file jointly").
agent_("file jointly","Alice").
agent_("file jointly","Bob").
start_("file jointly","2017-01-01").
end_("file jointly","2017-12-31").

% Test
:- tax("Alice",2017,45946).
:- halt.
