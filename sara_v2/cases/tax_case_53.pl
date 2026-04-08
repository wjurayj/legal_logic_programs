% Text
% Alice has a brother, Bob, who was born January 31st, 2014. Alice's gross income in 2020 was $604312. Alice married Charlie on October 12th, 1992. Charlie had no income in 2020. Alice and Charlie file jointly and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2020? $206332

% Facts
:- [statutes/prolog/init].
brother_("brother").
agent_("brother","Bob").
patient_("brother","Alice").
start_("brother","2014-01-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",604312).
start_("gross income","2020-12-31").
marriage_("married").
agent_("married","Alice").
agent_("married","Charlie").
start_("married","1992-10-12").
joint_return_("file jointly").
agent_("file jointly","Alice").
agent_("file jointly","Charlie").
start_("file jointly","2020-01-01").
end_("file jointly","2020-12-31").

% Test
:- tax("Alice",2020,206332).
:- halt.
