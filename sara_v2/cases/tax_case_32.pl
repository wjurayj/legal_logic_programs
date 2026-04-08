% Text
% Alice's gross income in 2019 was $5723215. Alice has employed Bob from Jan 2nd, 2011 to Feb 10, 2019. Alice paid Bob $3255 in 2019. On Oct 10, 2019 Bob retired because he reached age 65. Alice paid Bob $12980 as a retirement bonus. In 2019, Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2019? $2242833

% Facts
:- [statutes/prolog/init].
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",5723215).
start_("gross income","2019-12-31").
service_("employed").
patient_("employed","Alice").
agent_("employed","Bob").
start_("employed","2011-01-02").
end_("employed","2019-10-10").
payment_("Alice paid Bob $3255").
agent_("Alice paid Bob $3255","Alice").
patient_("Alice paid Bob $3255","Bob").
start_("Alice paid Bob $3255","2019-12-31").
amount_("Alice paid Bob $3255",3255).
purpose_("Alice paid Bob $3255","employed").
retirement_("retired").
agent_("retired","Bob").
start_("retired","2019-02-10").
reason_("retired","reached age 65").
payment_("Alice paid Bob $12980").
agent_("Alice paid Bob $12980","Alice").
patient_("Alice paid Bob $12980","Bob").
start_("Alice paid Bob $12980","2019-02-10").
amount_("Alice paid Bob $12980",12980).
purpose_("Alice paid Bob $12980","employed").

% Test
:- tax("Alice",2019,2242833).
:- halt.
