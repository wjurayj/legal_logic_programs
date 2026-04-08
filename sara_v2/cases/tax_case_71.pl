% Text
% In 2017, Alice was paid $433320 in remuneration. Alice and Bob got married on Jan 1st, 2015. Bob's gross income for 2017 is $532134. Alice and Bob file a joint return for the year 2017 and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $356472

% Facts
:- [statutes/prolog/init].
payment_("paid").
patient_("paid","Alice").
start_("paid","2017-12-31").
amount_("paid",433320).
income_("gross income").
agent_("gross income","Bob").
start_("gross income","2017-12-31").
amount_("gross income",532134).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2015-01-01").
joint_return_("file a joint return").
agent_("file a joint return","Alice").
agent_("file a joint return","Bob").
start_("file a joint return","2017-01-01").
end_("file a joint return","2017-12-31").

% Test
:- tax("Alice",2017,356472).
:- halt.
