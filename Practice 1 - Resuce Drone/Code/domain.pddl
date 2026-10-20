(define (domain drone-rescue)
  (:requirements :strips)
  
  ;; Predicates
  (:predicates
    (drone-location ?d)           ; The drone is at location ?d
    (person-location ?p ?d)       ; The person ?p is stranded at location ?d
    (safe-zone ?d)                ; Location ?d is a safe zone
    (adjacent ?d1 ?d2)            ; Locations ?d1 and ?d2 are adjacent
    (rescued ?p)                  ; The person ?p has been rescued
    (carrying ?p)                 ; The drone is carrying the person
    (obstacle ?d)                 ; Location ?d is an obstacle
    (drone-free)
    (spot-free ?s)
    (spot ?s)
  )
  

  ;; Action: Move
  (:action move
    :parameters (?from ?to)
    :precondition (and 
      (drone-location ?from)
      (adjacent ?from ?to)
      (not (obstacle ?to))  ;; Can't move to a location that is an obstacle
    )
    :effect (and
      (not (drone-location ?from))
      (drone-location ?to)
    )
  )

  ;; Action: Pickup a person
  (:action pickup
    :parameters (?p ?d)
    :precondition (and 
      (drone-location ?d)
      (person-location ?p ?d)
      (drone-free)         ;; Ensure the drone is not carrying anyone
      (not (obstacle ?d))  ;; Can't pick up from an obstacle location
    )
    :effect (and
      (not (person-location ?p ?d))
      (carrying ?p)        ;; Drone is now carrying the person
      (not (drone-free))   ;; Drone is no longer free
    )
  )

  ;; Action: Dropoff a person at a safe zone
  (:action dropoff
    :parameters (?p ?d ?s)
    :precondition (and 
      (drone-location ?d)
      (safe-zone ?d)   ;; Drop only in a safe zone
      (carrying ?p)    ;; Only drop if carrying a person
      (not (obstacle ?d))  ;; Safe zone cannot be an obstacle
      (not (drone-free))
      (spot ?s)
      (spot-free ?s)

    )
    :effect (and
      (rescued ?p)     ;; Mark person as rescued
      (not (carrying ?p)) ;; The drone no longer carries the person
      (drone-free)     ;; Drone is now free to pick up another person
      (not(spot-free ?s))

    )
  )
  
  ;; Action: Empty the safe zone when it is full
  (:action empty-safe-zone
    :parameters (?s)
    :precondition (and
      (spot ?s)
      (not(spot-free ?s))
    )
    :effect (and
      (spot-free ?s)
    )
  )  


)
