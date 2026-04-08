% Text
% Alice was paid $200 in March 2017 for services performed at Johns Hopkins Hospital. Alice was a patient at Johns Hopkins Hospital from March 15th, 2017 to April 2nd, 2017. Bob is Alice's son since April 15th, 2014. Bob and Alice have the same principal place of abode, a house maintained by Alice. Alice takes the standard deduction in 2017.

% Question
% How much tax does Alice have to pay in 2017? $0

% Facts
:- [statutes/prolog/init].
hospital_("Johns Hopkins Hospital").
agent_("Johns Hopkins Hospital","Johns Hopkins Hospital").
service_("services").
patient_("services","Johns Hopkins Hospital").
agent_("services","Alice").
start_("services","2017-03-15").
end_("services","2017-03-31").
payment_("paid").
agent_("paid","Johns Hopkins Hospital").
patient_("paid","Alice").
start_("paid","2017-03-31").
purpose_("paid","services").
amount_("paid",200).
medical_patient_("a patient").
agent_("a patient","Alice").
patient_("a patient","Johns Hopkins Hospital").
start_("a patient","2017-03-15").
end_("a patient","2017-04-02").
son_("son").
agent_("son","Bob").
patient_("son","Alice").
start_("son","2014-04-15").
residence_("principal place of abode").
agent_("principal place of abode","Alice").
agent_("principal place of abode","Bob").
patient_("principal place of abode","a house").
start_("principal place of abode","2017-01-01").
end_("principal place of abode","2017-12-31").
payment_("maintained").
agent_("maintained","Alice").
purpose_("maintained","a house").
start_("maintained","2017-12-31").
amount_("maintained",1).

% Test
:- tax("Alice",2017,0).
:- halt.
