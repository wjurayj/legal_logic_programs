% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice was a nonresident alien. Alice died on July 9th, 2014. Bob married Charlie on September 14th, 2015. Bob's gross income for the year 2015 is $28864, Charlie's gross income is $27953. Bob and Charlie file jointly in 2015 and take the standard deduction.

% Question
% How much tax does Bob have to pay in 2015? $8312

% Facts
:- [statutes/prolog/init].
marriage_("Alice and Bob got married").
agent_("Alice and Bob got married","Alice").
agent_("Alice and Bob got married","Bob").
start_("Alice and Bob got married","1992-02-03").
nonresident_alien_("a nonresident alien").
agent_("a nonresident alien","Alice").
death_("died").
agent_("died","Alice").
start_("died","2014-07-09").
end_("died","2014-07-09").
marriage_("Bob married Charlie").
agent_("Bob married Charlie","Charlie").
agent_("Bob married Charlie","Bob").
start_("Bob married Charlie","2015-09-14").
income_("Bob's gross income").
agent_("Bob's gross income","Bob").
start_("Bob's gross income","2015-12-31").
amount_("Bob's gross income",28864).
income_("Charlie's gross income").
agent_("Charlie's gross income","Charlie").
start_("Charlie's gross income","2015-12-31").
amount_("Charlie's gross income",27953).
joint_return_("file jointly").
agent_("file jointly","Bob").
agent_("file jointly","Charlie").
start_("file jointly","2015-01-01").
end_("file jointly","2015-12-31").

% Test
:- tax("Bob",2015,8312).
:- halt.
