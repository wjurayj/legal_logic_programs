% Text
% In 2017, Alice was paid $75845. Alice has a son, Bob. From September 1st, 2015 to November 3rd, 2019, Alice and Bob lived in the same home, which Alice maintained. In 2017, Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $15037

% Facts
:- [statutes/prolog/init].
payment_("was paid").
patient_("was paid","Alice").
start_("was paid","2017-12-31").
amount_("was paid",75845).
son_("has a son").
agent_("has a son","Bob").
patient_("has a son","Alice").
residence_("lived").
agent_("lived","Alice").
agent_("lived","Bob").
patient_("lived","home").
start_("lived","2015-09-01").
end_("lived","2019-11-03").
payment_("maintained").
agent_("maintained","Alice").
amount_("maintained",1).
start_("maintained","2015-09-01").
purpose_("maintained","home").
payment_("maintained").
agent_("maintained","Alice").
amount_("maintained",1).
start_("maintained","2016-01-01").
purpose_("maintained","home").
payment_("maintained").
agent_("maintained","Alice").
amount_("maintained",1).
start_("maintained","2017-01-01").
purpose_("maintained","home").
payment_("maintained").
agent_("maintained","Alice").
amount_("maintained",1).
start_("maintained","2018-01-01").
purpose_("maintained","home").
payment_("maintained").
agent_("maintained","Alice").
amount_("maintained",1).
start_("maintained","2019-01-01").
purpose_("maintained","home").

% Test
:- tax("Alice",2017,15037).
:- halt.
