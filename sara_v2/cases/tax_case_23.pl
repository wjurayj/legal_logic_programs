% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice died on July 9th, 2014. In 2014, Alice's gross income was $55431 and Bob's gross income was $64314. Bob files a joint return for himself and Alice for 2014. Bob takes the standard deduction.

% Question
% How much tax does Bob have to pay in 2014? $26549

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1992-02-03").
death_("died").
agent_("died","Alice").
start_("died","2014-07-09").
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",55431).
start_("Alice's gross income","2014-12-31").
income_("Bob's gross income").
agent_("Bob's gross income","Bob").
amount_("Bob's gross income",64314).
start_("Bob's gross income","2014-12-31").
joint_return_("files a joint return").
agent_("files a joint return","Bob").
agent_("files a joint return","Alice").
start_("files a joint return","2014-01-01").
end_("files a joint return","2014-12-31").

% Test
:- tax("Bob",2014,26549).
:- halt.
