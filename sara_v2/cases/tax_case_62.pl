% Text
% Alice married Bob on August 25th, 2011. Alice files a joint return with her husband for 2017. Alice's and Bob's gross income for the year 2017 is $22895 and they take the standard deduction. Alice is 67 years old in 2017.

% Question
% How much tax does Alice have to pay in 2017? $1844

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2011-08-25").
joint_return_("files a joint return").
agent_("files a joint return","Alice").
agent_("files a joint return","Bob").
start_("files a joint return","2017-01-01").
end_("files a joint return","2017-12-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",22895).
start_("gross income","2017-12-31").
birth_("67 years old").
agent_("67 years old","Alice").
start_("67 years old","1950-01-01").

% Test
:- tax("Alice",2017,1844).
:- halt.
