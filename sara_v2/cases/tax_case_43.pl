% Text
% In 2017, Alice was paid $23191. Alice and Bob got married on Feb 3rd, 1992. Alice was a nonresident alien until July 9th, 2014. Bob earned $34081 in 2017. Alice and Bob file jointly in 2017 and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $8439

% Facts
:- [statutes/prolog/init].
payment_("paid").
patient_("paid","Alice").
start_("paid","2017-12-31").
amount_("paid",23191).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","1992-02-03").
nonresident_alien_("a nonresident alien").
agent_("a nonresident alien","Alice").
end_("a nonresident alien","2014-07-09").
income_("earned").
agent_("earned","Bob").
amount_("earned",34081).
start_("earned","2017-12-31").
joint_return_("file jointly").
agent_("file jointly","Alice").
agent_("file jointly","Bob").
start_("file jointly","2017-01-01").
end_("file jointly","2017-12-31").

% Test
:- tax("Alice",2017,8439).
:- halt.
