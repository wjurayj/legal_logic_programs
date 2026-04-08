% Text
% Alice got married on Dec 10th, 2009. Alice's gross income for the year 2016 is $554313. Alice files separately and takes the standard deduction. Her husband's gross income in 2016 is $56298 and he takes itemized deductions of $4421.

% Question
% How much tax does Alice have to pay in 2016? $207772

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Her husband").
start_("married","2009-12-10").
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",554313).
start_("Alice's gross income","2016-12-31").
income_("Her husband's gross income").
agent_("Her husband's gross income","Her husband").
amount_("Her husband's gross income",56298).
start_("Her husband's gross income","2016-12-31").
deduction_("itemized deductions").
agent_("itemized deductions","Her husband").
start_("itemized deductions","2016-01-01").
amount_("itemized deductions",4421).

% Test
:- tax("Alice",2016,207772).
:- halt.
