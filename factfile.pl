% state(s).
% transition(Source, Destination, Event, Guard, Action)

% Top-level states
state(dormant).
state(init).
state(idle).
state(monitoring).
state(error_diagnosis).
state(safe_shutdown).

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

% Transitions within top-level
transition(dormant, exit, kill, null, null).
transition(dormant, init, start, null, null).
transition(init, idle, init_ok, null, null).
transition(idle, monitoring, begin_monitoring, null, null).
transition(init, error_diagnosis, init_crash, null, init_err_msg).
transition(error_diagnosis, init, null, 'retry < 3', retry_init;'retry++').
transition(error_diagnosis, safe_shutdown, null, 'retry => 3', shutdown).
transition(safe_shutdown, dormant, sleep, null, null).
transition(idle, error_diagnosis, idle_crash, null, idle_err_msg).
transition(error_diagnosis, idle, idle_rescue, null, null).
transition(monitoring, error_diagnosis, monitor_crash, null, moni_err_msg).
transition(error_diagnosis, monitoring, moni_rescue, null, null).

% Transitions within init state
transition(boot_hk, senchk, hw_ok, null, null).
transition(senchk, tchk, senok, null, null).
transition(tchk, psichk, t_ok, null, null).
transition(psichk, ready, psi_ok, null, null).


% Transitions within monitoring state
transition(monidle, regulate_environment, no_contagion, null, null).
transition(regulate_environment, monidle, after_100ms, null, null).
transition(monidle, lockdown, contagion_alert, null, FACILITY_CRIT_MESG;'inlockdown=true').
transition(lockdown, monidle, purge_succ, null, 'inlockdown=false').

% Transitions within lockdown state
transition(prep_vpurge, alt_temp, initiate_purge, null, lock_doors).
transition(prep_vpurge, alt_psi, initiate_purge, null, lock_doors).
transition(alt_temp, risk_assess, tcyc_comp, null, null).
transition(alt_psi, risk_assess, psicyc_comp, null, null).
transition(risk_assess, prep_vpurge, null, 'risk > 1%', null).
transition(risk_assess, safe_status, null, 'risk < 1%', unlock_doors).
transition(safe_status, exit, null, null, null).

% Transitions within error diagnosis state
transition(error_rcv, applicable_rescue, null, 'err_protocol_def=true', null).
transition(error_rcv, reset_module_data, null, 'err_protocol_def=false', null).
transition(applicable_rescue, exit, apply_protocol_rescues, null, null).
transition(reset_module_data, exit, reset_to_stable, null, null).








