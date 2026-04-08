% Text
% Alice got married on Jan 6th, 2005. Alice files a joint return with her spouse for 2015. Alice's and her spouse's gross income for the year 2015 is $42876. Alice and her spouse take the standard deduction. Alice has a son, Bob, who has the same principal place of abode as her in 2015. Bob has a son, Charlie, who also has the same principal place of abode as his father in 2015.

% Question
% How much tax does Alice have to pay in 2015? $4331

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","her spouse").
start_("married","2005-01-06").
joint_return_("files a joint return").
agent_("files a joint return","Alice").
agent_("files a joint return","her spouse").
start_("files a joint return","2015-01-01").
end_("files a joint return","2015-12-31").
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2015-12-31").
amount_("gross income",42876).
residence_("the same principal place of abode as her").
agent_("the same principal place of abode as her","Alice").
patient_("the same principal place of abode as her","the same principal place of abode").
start_("the same principal place of abode as her","2015-01-01").
end_("the same principal place of abode as her","2015-12-31").
son_("Alice has a son, Bob").
agent_("Alice has a son, Bob","Bob").
patient_("Alice has a son, Bob","Alice").
residence_("the same principal place of abode as his father").
agent_("the same principal place of abode as his father","Bob").
patient_("the same principal place of abode as his father","the same principal place of abode as her").
start_("the same principal place of abode as his father","2015-01-01").
end_("the same principal place of abode as his father","2015-12-31").
son_("Bob has a son, Charlie").
agent_("Bob has a son, Charlie","Charlie").
patient_("Bob has a son, Charlie","Bob").
residence_("the same principal place of abode as his father").
agent_("the same principal place of abode as his father","Charlie").
patient_("the same principal place of abode as his father","the same principal place of abode as her").
start_("the same principal place of abode as his father","2015-01-01").
end_("the same principal place of abode as his father","2015-12-31").

% Test
:- tax("Alice",2015,4331).
:- halt.
