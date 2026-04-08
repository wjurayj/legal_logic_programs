% Text
% Alice has paid $23200 in remuneration to Bob for agricultural labor done from Feb 1st, 2017 to Sep 2nd, 2017, in Caracas, Venezuela. Bob is an American citizen. Alice is an American employer. In 2017, Alice maintains as her principal place of abode a house where her mother Dorothy lives. Alice's gross income for the year 2017 is $197407. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $55528

% Facts
:- [statutes/prolog/init].
service_("agricultural labor").
patient_("agricultural labor","Alice").
agent_("agricultural labor","Bob").
start_("agricultural labor","2017-02-01").
end_("agricultural labor","2017-09-02").
location_("agricultural labor","Caracas, Venezuela").
country_("Caracas, Venezuela", "Venezuela").
purpose_("agricultural labor","agricultural labor").
payment_("paid").
agent_("paid","Alice").
patient_("paid","Bob").
start_("paid","2017-09-02").
purpose_("paid","agricultural labor").
amount_("paid",23200).
american_employer_("an American employer").
agent_("an American employer","Alice").
citizenship_("an American citizen").
agent_("an American citizen","Bob").
patient_("an American citizen","USA").
residence_("her principal place of abode").
agent_("her principal place of abode","Alice").
patient_("her principal place of abode","a house").
start_("her principal place of abode","2017-01-01").
end_("her principal place of abode","2017-12-31").
payment_("maintains").
agent_("maintains","Alice").
amount_("maintains",1).
start_("maintains","2017-01-01").
purpose_("maintains","a house").
mother_("mother").
agent_("mother","Dorothy").
patient_("mother","Alice").
residence_("lives").
agent_("lives","Dorothy").
patient_("lives","a house").
start_("lives","2017-01-01").
end_("lives","2017-12-31").
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2017-12-31").
amount_("gross income",197407).

% Test
:- tax("Alice",2017,55528).
:- halt.
