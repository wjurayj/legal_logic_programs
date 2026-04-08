% Text
% Alice has a brother, Bob, who was born January 31st, 2014 and has always lived at his parents' place. In 2016, Alice's gross income was $567192. Alice got married on Jan 12, 2016. Her husband had no income in 2016. Alice does not file a joint return. Alice has itemized deductions of $100206.

% Question
% How much tax does Alice have to pay in 2016? $178147

% Facts
:- [statutes/prolog/init].
brother_("brother").
agent_("brother","Bob").
patient_("brother","Alice").
start_("brother","2014-01-31").
son_("his parents'").
agent_("his parents'","Bob").
patient_("his parents'","his parents").
start_("his parents'","2014-01-31").
residence_("his parents' place").
agent_("his parents' place","his parents").
patient_("his parents' place","his parents' place").
residence_("lived").
agent_("lived","Bob").
patient_("lived","his parents' place").
start_("lived","2014-01-31").
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2016-12-31").
amount_("gross income",567192).
marriage_("married").
agent_("married","Alice").
agent_("married","Her husband").
start_("married","2016-01-12").
deduction_("itemized deductions").
agent_("itemized deductions","Alice").
amount_("itemized deductions",100206).
start_("itemized deductions","2016-01-01").

% Test
:- tax("Alice",2016,178147).
:- halt.
