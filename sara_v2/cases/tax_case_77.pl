% Text
% Alice's gross income for the year 2023 is $54775. In 2023, Bob, the son of her son Charlie, lives at her place, a house that she maintains. Bob has no income in 2023. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2023? $6449

% Facts
:- [statutes/prolog/init].
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",54775).
start_("gross income","2023-12-31").
son_("Bob, the son of").
agent_("Bob, the son of","Bob").
patient_("Bob, the son of","Charlie").
son_("her son").
agent_("her son","Charlie").
patient_("her son","Alice").
residence_("her place").
agent_("her place","Alice").
patient_("her place","a house").
start_("her place","2023-01-01").
end_("her place","2023-12-31").
residence_("lives").
agent_("lives","Bob").
patient_("lives","a house").
start_("lives","2023-01-01").
end_("lives","2023-12-31").
payment_("maintains").
agent_("maintains","Alice").
amount_("maintains",1).
start_("maintains","2023-01-01").
purpose_("maintains","a house").

% Test
:- tax("Alice",2023,6449).
:- halt.
