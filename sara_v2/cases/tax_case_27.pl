% Text
% In 2017, Alice was paid $33200. Bob is Alice's father since April 15th, 1978. In 2017, Alice and Bob lived in a house that Alice maintained. In 2017, Alice takes the standard deduction. Bob had no income in 2017.

% Question
% How much tax does Alice have to pay in 2017? $3720

% Facts
:- [statutes/prolog/init].
payment_("paid").
patient_("paid","Alice").
start_("paid","2017-12-31").
amount_("paid",33200).
father_("father").
agent_("father","Bob").
patient_("father","Alice").
start_("father","1978-04-15").
residence_("lived").
agent_("lived","Alice").
agent_("lived","Bob").
patient_("lived","a house").
start_("lived","2017-01-01").
end_("lived","2017-12-31").
payment_("maintained").
agent_("maintained","Alice").
amount_("maintained",1).
purpose_("maintained","a house").
start_("maintained","2017-12-31").

% Test
:- tax("Alice",2017,3720).
:- halt.
