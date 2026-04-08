% Text
% Alice was paid $1200 in 2019 for services performed in jail. Alice was committed to jail from January 24, 2015 to May 5th, 2019. From May 5th 2019 to Dec 31st 2019, Alice was paid $5320 in remuneration. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2019? $0

% Facts
:- [statutes/prolog/init].
service_("services").
patient_("services","jail").
agent_("services","Alice").
start_("services","2019-01-01").
end_("services","2019-05-05").
% start_("services","2019-05-05").
% end_("services","2019-12-31").
payment_("Alice was paid $1200 in 2019 for services performed in jail").
agent_("Alice was paid $1200 in 2019 for services performed in jail","jail").
patient_("Alice was paid $1200 in 2019 for services performed in jail","Alice").
start_("Alice was paid $1200 in 2019 for services performed in jail","2019-05-05").
purpose_("Alice was paid $1200 in 2019 for services performed in jail","services").
amount_("Alice was paid $1200 in 2019 for services performed in jail",1200).
penal_institution_("jail").
agent_("jail","jail").
incarceration_("committed to jail").
agent_("committed to jail","Alice").
patient_("committed to jail","jail").
start_("committed to jail","2015-01-24").
end_("committed to jail","2019-05-05").
payment_("From May 5th 2019 to Dec 31st 2019, Alice was paid $5320 in remuneration").
patient_("From May 5th 2019 to Dec 31st 2019, Alice was paid $5320 in remuneration","Alice").
amount_("From May 5th 2019 to Dec 31st 2019, Alice was paid $5320 in remuneration",5320).
% start_("From May 5th 2019 to Dec 31st 2019, Alice was paid $5320 in remuneration","2019-12-31").
start_("From May 5th 2019 to Dec 31st 2019, Alice was paid $5320 in remuneration","2019-05-05").
end_("From May 5th 2019 to Dec 31st 2019, Alice was paid $5320 in remuneration","2019-12-31").

% Test
:- tax("Alice",2019,0).
:- halt.
