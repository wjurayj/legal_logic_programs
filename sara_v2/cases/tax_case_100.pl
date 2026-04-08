% Text
% Alice's gross income for the year 2006 is $97407. Bob's gross income for the year 2006 is $136370. Alice and Bob have been married since Feb 3rd, 2006. Bob and Alice file a joint return for 2006 and take the standard deduction.

% Question
% How much tax does Bob have to pay in 2006? $66088

% Facts
:- [statutes/prolog/init].
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",97407).
start_("Alice's gross income","2006-12-31").
income_("Bob's gross income").
agent_("Bob's gross income","Bob").
amount_("Bob's gross income",136370).
start_("Bob's gross income","2006-12-31").
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2006-02-03").
joint_return_("file a joint return").
agent_("file a joint return","Bob").
agent_("file a joint return","Alice").
start_("file a joint return","2006-01-01").
end_("file a joint return","2006-12-31").

% Test
:- tax("Alice",2006,66088).
:- halt.
