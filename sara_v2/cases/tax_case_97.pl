% Text
% Alice has paid $4512 to Bob for work done from Feb 1st, 2005 to Sep 2nd, 2005. In 2005, Alice was paid $133200. Alice is allowed itemized deductions of $2939 and $8744.

% Question
% How much tax does Alice have to pay in 2005? $33069

% Facts
:- [statutes/prolog/init].
service_("work").
patient_("work","Alice").
agent_("work","Bob").
start_("work","2005-02-01").
end_("work","2005-09-02").
payment_("Alice has paid $4512 to Bob").
agent_("Alice has paid $4512 to Bob","Alice").
patient_("Alice has paid $4512 to Bob","Bob").
start_("Alice has paid $4512 to Bob","2005-09-02").
purpose_("Alice has paid $4512 to Bob","work").
amount_("Alice has paid $4512 to Bob",4512).
payment_("Alice was paid $133200").
patient_("Alice was paid $133200","Alice").
start_("Alice was paid $133200","2005-12-31").
amount_("Alice was paid $133200",133200).
deduction_("$2939").
agent_("$2939","Alice").
amount_("$2939",2939).
start_("$2939","2005-01-01").
deduction_("$8744").
agent_("$8744","Alice").
amount_("$8744",8744).
start_("$8744","2005-01-01").

% Test
:- tax("Alice",2005,33069).
:- halt.
