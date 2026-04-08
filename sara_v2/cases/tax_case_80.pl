% Text
% Alice's gross income for the year 2014 is $97407. In 2014, Alice's father Bob lived at the house that Alice maintains and resides in. Alice takes the standard deduction in 2014.

% Question
% How much tax does Alice have to pay in 2014? $21452

% Facts
:- [statutes/prolog/init].
father_("father").
agent_("father","Bob").
patient_("father","Alice").
residence_("lived").
agent_("lived","Bob").
patient_("lived","the house").
start_("lived","2014-01-01").
end_("lived","2014-12-31").
payment_("maintains").
agent_("maintains","Alice").
amount_("maintains",1).
start_("maintains","2014-01-01").
purpose_("maintains","the house").
residence_("resides").
agent_("resides","Alice").
patient_("resides","the house").
start_("resides","2014-01-01").
end_("resides","2014-12-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",97407).
start_("gross income","2014-12-31").

% Test
:- tax("Alice",2014,21452).
:- halt.
