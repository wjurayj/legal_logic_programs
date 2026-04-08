% Text
% In 2016, Alice was paid $51020 in remuneration. Alice and Bob have been married since Feb 3rd, 2016, and they file a joint return for 2016. Bob's gross income in 2016 was $42939. Alice and Bob take itemized deductions of $21137.

% Question
% How much tax does Alice have to pay in 2016? $14473

% Facts
:- [statutes/prolog/init].
payment_("paid").
patient_("paid","Alice").
start_("paid","2016-12-31").
amount_("paid",51020).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2016-02-03").
joint_return_("file a joint return").
agent_("file a joint return","Alice").
agent_("file a joint return","Bob").
start_("file a joint return","2016-01-01").
end_("file a joint return","2016-12-31").
income_("gross income").
agent_("gross income","Bob").
amount_("gross income",42939).
start_("gross income","2016-12-31").
deduction_("itemized deductions").
agent_("itemized deductions","Alice").
amount_("itemized deductions",21137).
start_("itemized deductions","2016-12-31").

% Test
:- tax("Alice",2016,14473).
:- halt.
