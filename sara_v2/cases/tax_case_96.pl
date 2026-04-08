% Text
% Alice's income for the year 2003 is $54313. Alice and Bob have been married since Feb 3rd, 1985. Bob had no income in 2003. Bob and Alice file a joint return for 2003 and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2003? $7611

% Facts
:- [statutes/prolog/init].
income_("Alice's income").
agent_("Alice's income","Alice").
start_("Alice's income","2003-12-31").
amount_("Alice's income",54313).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1985-02-03").
joint_return_("file a joint return").
agent_("file a joint return","Bob").
agent_("file a joint return","Alice").
start_("file a joint return","2003-01-01").
end_("file a joint return","2003-12-31").

% Test
:- tax("Alice",2003,7611).
:- halt.
