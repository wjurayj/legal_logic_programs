% Text
% Bob is Alice's father. Alice's gross income in 2015 is $311510. Bob has no income in 2015. Alice takes the standard deduction in 2015.

% Question
% How much tax does Alice have to pay in 2015? $102150

% Facts
:- [statutes/prolog/init].
father_("father").
agent_("father","Bob").
patient_("father","Alice").
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
start_("Alice's gross income","2015-01-01").
end_("Alice's gross income","2015-12-31").
amount_("Alice's gross income",311510).

% Test
:- tax("Alice",2015,102150).
:- halt.
