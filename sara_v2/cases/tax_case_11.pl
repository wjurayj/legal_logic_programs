% Text
% Charlie is Bob's father since April 15th, 2014, and Bob has lived at Charlie's place since then. Alice is Charlie's sister since October 12th, 1992. Charlie's gross income in 2015 was $52650. In 2015, Alice's gross income was $2312. Alice takes the standard deduction in 2015.

% Question
% How much tax does Alice have to pay in 2015? $0

% Facts
:- [statutes/prolog/init].
father_("father").
agent_("father","Charlie").
patient_("father","Bob").
start_("father","2014-04-15").
residence_("Charlie's place").
agent_("Charlie's place","Charlie").
patient_("Charlie's place","Charlie's place").
start_("Charlie's place","2014-01-01").
residence_("lived").
agent_("lived","Bob").
patient_("lived","Charlie's place").
start_("lived","2014-04-15").
sister_("sister").
agent_("sister","Alice").
patient_("sister","Charlie").
start_("sister","1992-10-12").
income_("Charlie's gross income").
agent_("Charlie's gross income","Charlie").
amount_("Charlie's gross income",52650).
start_("Charlie's gross income","2015-01-01").
end_("Charlie's gross income","2015-12-31").
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
amount_("Alice's gross income",2312).
start_("Alice's gross income","2015-01-01").
end_("Alice's gross income","2015-12-31").

% Test
:- tax("Alice",2015,0).
:- halt.
