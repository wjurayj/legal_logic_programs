% Text
% Alice got married on December 30th, 2017. Alice files a joint return with her spouse for 2017. Alice's and her spouse's gross income for the year 2017 is $684642. Alice has itemized deductions of $23029 for donating cash to a charity.

% Question
% How much tax does Alice have to pay in 2017? $243097

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","her spouse").
start_("married","2017-12-30").
joint_return_("files a joint return").
agent_("files a joint return","Alice").
agent_("files a joint return","her spouse").
start_("files a joint return","2017-01-01").
end_("files a joint return","2017-12-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",684642).
start_("gross income","2017-12-31").
deduction_("itemized deductions").
agent_("itemized deductions","Alice").
amount_("itemized deductions",23029).
start_("itemized deductions","2017-12-31").

% Test
:- tax("Alice",2017,243097).
:- halt.
