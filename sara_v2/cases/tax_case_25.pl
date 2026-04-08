% Text
% Bob is Charlie and Dorothy's son, born on April 15th, 2015. Alice married Charlie on August 8th, 2018. Alice's and Charlie's gross incomes in 2018 were $324311 and $414231 respectively. Alice, Bob and Charlie have the same principal place of abode in 2018. Alice and Charlie file jointly in 2018, and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2018? $259487

% Facts
:- [statutes/prolog/init].
son_("son").
agent_("son","Bob").
patient("son","Charlie").
patient("son","Dorothy").
start_("son","2015-04-15").
marriage_("married").
agent_("married","Alice").
agent_("married","Charlie").
start_("married","2018-08-08").
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",324311).
start_("Alice's gross income","2018-12-31").
income_("Charlie's gross income").
agent_("Charlie's gross income","Charlie").
amount_("Charlie's gross income",414231).
start_("Charlie's gross income","2018-12-31").
residence_("principal place of abode").
agent_("principal place of abode","Alice").
agent_("principal place of abode","Bob").
agent_("principal place of abode","Charlie").
patient_("principal place of abode","principal place of abode").
start_("principal place of abode","2018-01-01").
end_("principal place of abode","2018-12-31").
joint_return_("file jointly").
agent_("file jointly","Alice").
agent_("file jointly","Charlie").
start_("file jointly","2018-01-01").
end_("file jointly","2018-12-31").

% Test
:- tax("Alice",2018,259487).
:- halt.
