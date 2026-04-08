% Text
% Alice has paid $300 to Bob for domestic service done in her home from Feb 1st, 2010 to Sep 2nd, 2010, in Baltimore, Maryland, USA. In 2010, Alice was paid $33408. Alice is allowed itemized deductions of $680, $2102, $1993 and $4807.

% Question
% How much tax does Alice have to pay in 2010? $3274

% Facts
:- [statutes/prolog/init].
service_("domestic service").
patient_("domestic service","Alice").
agent_("domestic service","Bob").
start_("domestic service","2010-02-01").
end_("domestic service","2010-09-02").
location_("domestic service","Baltimore").
location_("domestic service","Maryland").
location_("domestic service","USA").
purpose_("domestic service","domestic service").
location_("domestic service","her home").
payment_("Alice has paid $300 to Bob").
agent_("Alice has paid $300 to Bob","Alice").
patient_("Alice has paid $300 to Bob","Bob").
start_("Alice has paid $300 to Bob","2010-09-02").
purpose_("Alice has paid $300 to Bob","domestic service").
amount_("Alice has paid $300 to Bob",300).
payment_("Alice was paid $33408").
patient_("Alice was paid $33408","Alice").
start_("Alice was paid $33408","2010-12-31").
amount_("Alice was paid $33408",33408).
deduction_("$680").
agent_("$680","Alice").
start_("$680","2010-01-01").
amount_("$680",680).
deduction_("$2102").
agent_("$2102","Alice").
start_("$2102","2010-01-01").
amount_("$2102",2102).
deduction_("$1993").
agent_("$1993","Alice").
start_("$1993","2010-01-01").
amount_("$1993",1993).
deduction_("$4807").
agent_("$4807","Alice").
start_("$4807","2010-01-01").
amount_("$4807",4807).

% Test
:- tax("Alice",2010,3274).
:- halt.
