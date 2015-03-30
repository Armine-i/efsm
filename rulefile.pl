%% Rules
is_loop(Event, Guard) :-
                        dif(null, Guard),
                        dif(null, Event),
                        transition(S1, S1, Event, Guard, _).

all_loops(Set) :-
                  findall(S1, (transition(S1, S1, Event, Guard, _), is_loop(Event, Guard)), L),
                  list_to_set(L, Set).
                  
is_edge(Event, Guard) :-
                        transition(_, _, Event, Guard, _),
                        dif(null, Guard),
                        dif(null, Event).
                        
size(Length) :-
              findall(transition(_, _, Event, Guard, _), is_edge(Event, Guard), L),
              length(L, Length).
              
is_link(Event, Guard) :- transition(_, _, Event, Guard, _).

all_superstates(Set) :-
                       findall(State, superstate(State, _), L),
                       list_to_set(L, Set).
                       
ancestor(Ancestor, Descendant) :- transition(Ancestor, Descendant, _, _, _).

inheritss_transitions(State, List) :- findall((State, S2, E, G, A), transition(State, S2, E, G, A), List).

all_states(L) :- findall(State, state(State), L).

all_init_states(L) :- findall(State, initial_state(State, _), L).

get_starting_state(State) :- initial_state(State, null).

state_is_reflexive(State) :- transition(State, State, _, _, _).

graph_is_reflexive :- state(state_is_reflexive(State)).

get_guards(Ret):-
                  findall(Guard, transition(_, _, _, Guard, _), L),
                  list_to_set(L, Ret).
                  
get_events(Ret):-
                  findall(Event, transition(_, _, Event, _, _), L),
                  list_to_set(L, Ret).
                  
get_actions(Ret):-
                  findall(Action, transition(_, _, _, _, Action), L),
                  list_to_set(L, Ret).
                  
get_only_guarded(Ret):-
                        dif(null, Guard),
                        findall((S, S2), transition(S, S2, _, Guard, _), L),
                        list_to_set(L, Ret).
                        
legal_events_of(State, L):-
                            dif(null, Guard),
                            dif(null, Event),
                            findall((Event, Guard), transition(State, _, Event, Guard, _), L).
