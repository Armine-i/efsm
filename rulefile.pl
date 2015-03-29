is_loop(Event, Guard):- 

all_loops(Set):- 

is_edge(Event, Guard):- 

size(Length):- 

is_link(Event, Guard):- 

all_superstates(Set):- 

ancestor(Ancestor, Descendant):- transition(Ancestor, Descendant, _, _, _).

inherits_transitions(State, List):- 

all_states(L):- 

all_init_states(L):- 

get_starting_state(State):- 

get_guards(Ret):- findall(Guard, transition(_, _, _, Guard, _), L).
		  list_to_set(L, Ret).

get_events(Ret):- findall(Event, transition(_, _, Event, _, _), L).
		  list_to_set(L, Ret).

get_actions(Ret):- findall(Action, transition(_, _, _, _, Action), L).
		     list_to_set(L, Ret).

state_is_reflexive(State):- 

graph_is_reflexive:-

get_only_guarded(Ret):-

legal_events_of(States, L):-
