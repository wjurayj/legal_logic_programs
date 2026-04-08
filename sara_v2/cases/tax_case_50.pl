% Text
% Alice got married on October 9th, 2016. Alice files a joint return with her spouse for 2017. Alice's and her spouse's gross income for the year 2017 is $42876. They take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $4931

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","her spouse").
start_("married","2016-10-09").
joint_return_("files a joint return").
agent_("files a joint return","Alice").
agent_("files a joint return","her spouse").
start_("files a joint return","2017-01-01").
end_("files a joint return","2017-12-31").
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2017-12-31").
amount_("gross income",42876).

% Test
:- tax("Alice",2017,4931).
:- halt.
