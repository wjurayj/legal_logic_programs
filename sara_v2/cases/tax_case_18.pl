% Text
% Charlie is Alice's father since April 15th, 1994. Bob is Charlie's brother since October 12th, 1992. Alice's gross income in 2015 is $87319. Both Charlie and Bob have no income in 2015, and are not qualifying children to any taxpayer.

% Question
% How much tax does Alice have to pay in 2015? $19801

% Facts
:- [statutes/prolog/init].
father_("father").
agent_("father","Bob").
patient_("father","Alice").
start_("father","1994-04-15").
brother_("brother").
agent_("brother","Bob").
patient_("brother","Charlie").
start_("brother","1992-10-12").
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2015-12-31").
amount_("gross income",87319).

% Test
:- tax("Alice",2015,19801).
:- halt.
