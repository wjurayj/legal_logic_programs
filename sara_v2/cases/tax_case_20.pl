% Text
% In 2017, Alice's gross income was $310192. Since 2014, Alice maintains a house where she and her daughter live. Alice was married since Jan 14th, 2010 until her husband died on Nov 23rd, 2016. In 2017, Alice is allowed itemized deductions of $17890. Alice has paid $45252 to Bob for work done in the year 2017. In 2017, Alice has also paid $9832 into a retirement fund for Bob, and $5322 into health insurance for Charlie, who is Alice's father and has retired in 2016. Charlie had no income in 2017.

% Question
% How much tax does Alice have to pay in 2017? $90683

% Facts
:- [statutes/prolog/init].
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
start_("Alice's gross income","2017-12-31").
amount_("Alice's gross income",310192).
payment_("maintains").
agent_("maintains","Alice").
patient_("maintains","a house").
amount_("maintains",1).
purpose_("maintains","a house").
start_("maintains",Day) :- between(2014,2114,Year), first_day_year(Year,Day).
residence_("live").
agent_("live","Alice").
agent_("live","her daughter").
patient_("live","a house").
start_("live","2014-01-01").
daughter_("daughter").
agent_("daughter","her daughter").
patient_("daughter","Alice").
marriage_("married").
agent_("married","husband").
agent_("married","Alice").
start_("married","2010-01-14").
death_("died").
agent_("died","husband").
start_("died","2016-11-23").
service_("work").
patient_("work","Alice").
agent_("work","Bob").
start_("work","2017-01-01").
end_("work","2017-12-31").
payment_("Alice has paid $45252 to Bob").
agent_("Alice has paid $45252 to Bob","Alice").
patient_("Alice has paid $45252 to Bob","Bob").
start_("Alice has paid $45252 to Bob","2017-01-01").
end_("Alice has paid $45252 to Bob","2017-12-31").
purpose_("Alice has paid $45252 to Bob","work").
amount_("Alice has paid $45252 to Bob",45252).
payment_("Alice has also paid $9832 into a retirement fund").
agent_("Alice has also paid $9832 into a retirement fund","Alice").
patient_("Alice has also paid $9832 into a retirement fund","retirement fund").
purpose_("Alice has also paid $9832 into a retirement fund","make provisions for employees in case of retirement").
plan_("retirement fund").
beneficiary_("Alice has also paid $9832 into a retirement fund","Bob").
start_("Alice has also paid $9832 into a retirement fund","2017-01-01").
end_("Alice has also paid $9832 into a retirement fund","2017-12-31").
amount_("Alice has also paid $9832 into a retirement fund",9832).
payment_("$5322 into health insurance").
agent_("$5322 into health insurance","Alice").
patient_("$5322 into health insurance","health insurance").
plan_("health insurance").
purpose_("$5322 into health insurance","make provisions for employees in case of sickness").
beneficiary_("$5322 into health insurance","Charlie").
start_("$5322 into health insurance","2017-01-01").
end_("$5322 into health insurance","2017-12-31").
amount_("$5322 into health insurance",5322).
father_("father").
agent_("father","Charlie").
patient_("father","Alice").
retirement_("retired").
agent_("retired","Charlie").
start_("retired","2016-01-01").
deduction_("itemized deductions").
agent_("itemized deductions","Alice").
amount_("itemized deductions",17890).
start_("itemized deductions","2017-12-31").

% Test
:- tax("Alice",2017,90683).
:- halt.
