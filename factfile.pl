% state(s).
% transition(Source, Destination, Event, Guard, Action)

% Top-level states
state(dormant).
state(init).
state(idle).
state(monitoring).
state(error_diagnosis).

% States under init state
state(boot_hw).
state(senchk).
state(tchk).
state(psichk).
state(ready).

% States under monitor state
state(monidle).
state(regulate_environment).
state(lockdown).

% States under lockdown state
state(prep_vpurge).
state(alt_temp).
state(alt_psi).
state(risk_access).
state(safe_status).

% States under error diagnosis state
state(error_rcv).
state(applicable_rescue).
state(reset_module_data).

% Initial states
initial_state(dormant, null).
initial_state(boot_hw, init).
initial_state(monidle, monitoring).
initial_state(prep_vpurge, lockdown).
initial_state(error_rcv, error_diagnosis).

% Superstates
superstate(init, boot_hw).
superstate(init, senchk).
superstate(init, tchk).
superstate(init, psichk).
superstate(init, ready).

superstate(monitoring, monidle).
superstate(monitoring, regulate_environment).
superstate(monitoring, lockdown).

superstate(lockdown, prep_vpurge).
superstate(lockdown, alt_temp).
superstate(lockdown, alt_psi).
superstate(lockdown, risk_access).
superstate(lockdown, safe_status).

superstate(error_diagnosis, error_rcv).
superstate(error_diagnosis, applicable_rescue).
superstate(error_diagnosis, reset_module_data).


