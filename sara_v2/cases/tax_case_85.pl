% Text
% In 2019, Alice was paid $34510. Alice has a brother, Charlie, whose son Bob lived at Alice's place in 2019, a house that she maintains. In 2019, Charlie had a different principal place of abode, and Bob had no income. Alice takes the standard deduction in 2019.

% Question
% How much tax does Alice have to pay in 2019? $2477

% Facts
:- [statutes/prolog/init].
payment_("paid").
patient_("paid","Alice").
start_("paid","2019-12-31").
amount_("paid",34510).
brother_("brother").
agent_("brother","Charlie").
patient_("brother","Alice").
son_("son").
agent_("son","Bob").
patient_("son","Charlie").
residence_("lived").
agent_("lived","Bob").
patient_("lived","Alice's place").
start_("lived","2019-01-01").
end_("lived","2019-12-31").
residence_("Alice's place").
agent_("Alice's place","Alice").
patient_("Alice's place","Alice's place").
start_("Alice's place","2019-01-01").
end_("Alice's place","2019-12-31").
payment_("maintains").
agent_("maintains","Alice").
amount_("maintains",1).
start_("maintains","2019-01-01").
purpose_("maintains","Alice's place").
residence_("principal place of abode").
agent_("principal place of abode","Charlie").
patient_("principal place of abode","a different principal place of abode").
start_("principal place of abode","2019-01-01").
end_("principal place of abode","2019-12-31").

% Test
:- tax("Alice",2019,2477).
:- halt.
