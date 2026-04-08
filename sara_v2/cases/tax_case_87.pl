% Text
% Alice and Charlie have a son, Bob. From September 1st, 2015 to November 3rd, 2019, Alice, Bob and Charlie lived in the same home. Alice and Charlie got married on Feb 3rd, 1992. Alice is a nonresident alien. In 2018, Alice earned $643531. Charlie had no income in 2018. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2018? $243103

% Facts
:- [statutes/prolog/init].
son_("son").
agent_("son","Bob").
patient_("son","Alice").
patient_("son","Charlie").
residence_("lived").
agent_("lived","Alice").
agent_("lived","Bob").
agent_("lived","Charlie").
patient_("lived","the same home").
start_("lived","2015-09-01").
end_("lived","2019-11-03").
marriage_("married").
agent_("married","Alice").
agent_("married","Charlie").
start_("married","1992-02-03").
nonresident_alien_("a nonresident alien").
agent_("a nonresident alien","Alice").
income_("earned").
agent_("earned","Alice").
amount_("earned",643531).
start_("earned","2018-12-31").

% Test
:- tax("Alice",2018,243103).
:- halt.
