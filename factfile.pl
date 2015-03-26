% start(state).
% transition(current-state, condition, next-state).
% end(state).

% Top-level states
state(dormant).
state(init).
state(idle).
state(monitoring).
state(error_diagnosis).

% States under init state
