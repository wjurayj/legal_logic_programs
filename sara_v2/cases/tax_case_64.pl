% Text
% Alice has a brother, Bob, who was born January 31st, 2014. Alice's gross income in 2015 was $260932. Bob lived at Alice's house in 2015. For 2015, Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2015? $81487

% Facts
:- [statutes/prolog/init].
brother_("brother").
agent_("brother","Bob").
patient_("brother","Alice").
start_("brother","2014-01-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",260932).
start_("gross income","2015-01-01").
end_("gross income","2015-12-31").
residence_("lived").
agent_("lived","Alice").
agent_("lived","Bob").
patient_("lived","Alice's house").
start_("lived","2015-01-01").
end_("lived","2015-12-31").

% Test
:- tax("Alice",2015,81487).
:- halt.
