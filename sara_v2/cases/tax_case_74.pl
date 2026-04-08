% Text
% Alice was paid $200 in March 2017 for services performed at Johns Hopkins Hospital. Alice was a patient at Johns Hopkins Hospital from March 15th, 2017 to April 2nd, 2017. In 2017, Alice was also paid $31220 in remuneration. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $4525

% Facts
:- [statutes/prolog/init].
hospital_("Johns Hopkins Hospital").
agent_("Johns Hopkins Hospital","Johns Hopkins Hospital").
service_("services").
patient_("services","Johns Hopkins Hospital").
agent_("services","Alice").
start_("services","2017-03-15").
end_("services","2017-03-31").
payment_("Alice was paid $200").
agent_("Alice was paid $200","Johns Hopkins Hospital").
patient_("Alice was paid $200","Alice").
start_("Alice was paid $200","2017-03-31").
purpose_("Alice was paid $200","services").
amount_("Alice was paid $200",200).
medical_patient_("a patient").
agent_("a patient","Alice").
patient_("a patient","Johns Hopkins Hospital").
start_("a patient","2017-03-15").
end_("a patient","2017-04-02").
income_("Alice was also paid $31220").
agent_("Alice was also paid $31220","Alice").
start_("Alice was also paid $31220","2017-12-31").
amount_("Alice was also paid $31220",31220).

% Test
:- tax("Alice",2017,4525).
:- halt.
