% Text
% In 2018, Alice was paid $3200. Alice and Bob have been married since Feb 3rd, 2017. Alice and Bob file separate returns and each take their standard deduction. Bob had no income in 2018. Alice has been blind since March 20, 2016. Alice was enrolled at Johns Hopkins University and attending classes from August 29, 2015 to May 30th, 2019.

% Question
% How much tax does Alice have to pay in 2018? $0

% Facts
:- [statutes/prolog/init].
payment_("paid").
patient_("paid","Alice").
start_("paid","2018-12-31").
amount_("paid",3200).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2017-02-03").
blindness_("blind").
agent_("blind","Alice").
start_("blind","2016-03-20").
educational_institution_("Johns Hopkins University").
agent_("Johns Hopkins University","Johns Hopkins University").
enrollment_("enrolled").
agent_("enrolled","Alice").
patient_("enrolled","Johns Hopkins University").
start_("enrolled","2015-08-29").
end_("enrolled","2019-05-30").
attending_classes_("attending classes").
agent_("attending classes","Alice").
location_("attending classes","Johns Hopkins University").
start_("attending classes","2015-08-29").
end_("attending classes","2019-05-30").

% Test
:- tax("Alice",2018,0).
:- halt.
