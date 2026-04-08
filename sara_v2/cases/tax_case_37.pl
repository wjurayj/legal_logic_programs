% Text
% Alice was born January 10th, 1992. Bob was born January 31st, 2014. Alice adopted Bob on March 4th, 2018 and Bob has lived with Alice since, in a house that Alice maintains. Alice's gross income in 2018 was $141177. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2018? $32045

% Facts
:- [statutes/prolog/init].
birth_("Alice was born").
agent_("Alice was born","Alice").
start_("Alice was born","1992-01-10").
end_("Alice was born","1992-01-10").
birth_("Bob was born").
agent_("Bob was born","Bob").
start_("Bob was born","2014-01-31").
end_("Bob was born","2014-01-31").
son_("adopted").
agent_("adopted","Bob").
patient_("adopted","Alice").
start_("adopted","2018-03-04").
residence_("lived").
agent_("lived","Alice").
agent_("lived","Bob").
patient_("lived","a house").
start_("lived","2018-01-01").
payment_("maintains").
agent_("maintains","Alice").
amount_("maintains",1).
purpose_("maintains","a house").
start_("maintains","2018-01-01").
end_("maintains","2018-12-31").
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2018-12-31").
amount_("gross income",141177).

% Test
:- tax("Alice",2018,32045).
:- halt.
