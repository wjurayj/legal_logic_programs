% Text
% Alice got married on Feb 29, 2000. Alice files a joint return with her spouse for 2017. Alice's gross income for the year 2017 is $22895, and her spouse's is $14257. They take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $4073

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","her spouse").
start_("married","2000-02-29").
joint_return_("files a joint return").
agent_("files a joint return","Alice").
agent_("files a joint return","her spouse").
start_("files a joint return","2017-01-01").
end_("files a joint return","2017-12-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",22895).
start_("gross income","2017-12-31").
income_("her spouse's").
agent_("her spouse's","her spouse").
amount_("her spouse's",14257).
start_("her spouse's","2017-12-31").

% Test
:- tax("Alice",2017,4073).
:- halt.
