% Text
% Alice employed Bob from Jan 2nd, 2011 to Oct 10, 2019, paying him $1513 in 2019. On Oct 10, 2019 Bob was diagnosed as disabled and retired. Alice paid Bob $298 because she had to terminate their contract due to Bob's disability. In 2019, Alice's gross income was $567192. In 2019, Alice lived together with Charlie, her father, in a house that she maintains. Charlie had no income in 2019. Alice takes the standard deduction in 2019.

% Question
% How much tax does Alice have to pay in 2019? $196056

% Facts
:- [statutes/prolog/init].
service_("employed").
patient_("employed","Alice").
agent_("employed","Bob").
start_("employed","2011-01-02").
end_("employed","2019-10-10").
payment_("paying").
agent_("paying","Alice").
patient_("paying","Bob").
amount_("paying",1513).
purpose_("paying","employed").
start_("paying","2019-12-31").
disability_("disabled").
agent_("disabled","Bob").
start_("disabled","2019-10-10").
termination_("terminate").
agent_("terminate","Alice").
patient_("terminate","employed").
reason_("terminate","Bob's disability").
retirement_("retired").
agent_("retired","Bob").
start_("retired","2019-10-10").
reason_("retired","disability").
payment_("paid").
agent_("paid","Alice").
patient_("paid","Bob").
start_("paid","2019-10-10").
purpose_("paid","terminate").
amount_("paid",298).
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2019-12-31").
amount_("gross income",567192).
residence_("lived").
agent_("lived","Alice").
agent_("lived","Charlie").
patient_("lived","a house").
start_("lived","2019-01-01").
end_("lived","2019-12-31").
father_("father").
agent_("father","Charlie").
patient_("father","Alice").
payment_("maintains").
agent_("maintains","Alice").
amount_("maintains",1).
start_("maintains","2019-01-01").
purpose_("maintains","a house").

% Test
:- tax("Alice",2019,196056).
:- halt.
