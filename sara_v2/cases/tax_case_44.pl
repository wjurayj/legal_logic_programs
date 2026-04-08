% Text
% In 2017, Alice was paid $117192. Alice and Bob got married on Feb 3rd, 2017. Alice was a nonresident alien from August 23rd, 2016 to September 15th, 2018. Bob earned $37820 in 2017. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $34233

% Facts
:- [statutes/prolog/init].
payment_("paid").
patient_("paid","Alice").
start_("paid","2017-12-31").
amount_("paid",117192).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2017-02-03").
nonresident_alien_("a nonresident alien").
agent_("a nonresident alien","Alice").
start_("a nonresident alien","2016-08-23").
end_("a nonresident alien","2018-08-15").
income_("earned").
agent_("earned","Bob").
start_("earned","2017-12-31").
amount_("earned",37820).

% Test
:- tax("Alice",2017,34233).
:- halt.
