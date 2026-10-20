(define (domain robot-cook)
  (:requirements :strips :typing)
  (:types
    robot ingredient tool location dish
  )

  (:predicates
    (robot-at ?r - robot ?loc - location)  ; Robot is at a specific location
    (ingredient-at ?ingredient - ingredient ?loc - location)  ; Ingredient is at a specific location
    (tool-at ?tool - tool ?loc - location)  ; Tool is at a specific location
    (dish-prepared ?dish - dish)  ; The dish is fully prepared
    (tool-clean ?tool - tool)  ; The tool is clean and ready for use
    (holding ?item - (either ingredient tool))  ; Robot is holding an item (ingredient or tool)
    (adjacent ?loc1 - location ?loc2 - location)  ; Locations are adjacent
    (ingredient-mixed ?ingredient - ingredient)  ; Indicates an ingredient has been mixed
    (ingredient-cooked ?ingredient - ingredient)
    (mixing-location ?loc - location)  ; Indicates that a location is a mixing area
    (cooking-location ?loc - location)  ; Indicates that a location is a cooking area
    (cleaning-location ?loc - location)  ; Indicates that a location is a cleaning area
  )

  (:action move
    :parameters (?r - robot ?loc1 - location ?loc2 - location)
    :precondition (and 
      (robot-at ?r ?loc1) 
      (adjacent ?loc1 ?loc2))  ; Check if the locations are adjacent
    :effect (and 
      (not (robot-at ?r ?loc1)) 
      (robot-at ?r ?loc2))  ; Move robot to the new location
  )

  (:action pick-up-ingredient
    :parameters (?r - robot ?ingredient - ingredient ?loc - location)
    :precondition (and 
      (robot-at ?r ?loc) 
      (ingredient-at ?ingredient ?loc) 
      (not (holding ?ingredient)))  ; Robot is at the location of the ingredient
    :effect (and 
      (holding ?ingredient) 
      (not (ingredient-at ?ingredient ?loc)))  ; Robot picks up the ingredient
  )

  (:action prepare-ingredient
    :parameters (?r - robot ?ingredient - ingredient ?loc - location)
    :precondition (and 
      (robot-at ?r ?loc) 
      (holding ?ingredient))
    :effect (not (holding ?ingredient))  ; Robot prepares the ingredient
  )

  ;; Modified action: Cook ingredient now receives a location parameter
  (:action cook-ingredient
    :parameters (?r - robot ?ingredient - ingredient ?loc - location)
    :precondition (and 
      (robot-at ?r ?loc)             ; Robot must be in the specified location
      (holding ?ingredient)           ; Robot must be holding the ingredient
      (cooking-location ?loc))        ; Check that the location is a cooking area
    :effect (and
        (not (holding ?ingredient))
        (ingredient-cooked ?ingredient)
    )  ; Robot cooks the ingredient
  )

  ;; Modified action: Clean tool now receives a location parameter
  (:action clean-tool
    :parameters (?r - robot ?tool - tool ?loc - location)
    :precondition (and 
      (robot-at ?r ?loc)             ; Robot must be in the specified location
      (holding ?tool)                ; Robot must be holding the tool
      (cleaning-location ?loc))      ; Check that the location is a cleaning area
    :effect (and 
      (tool-clean ?tool)             ; Tool is now clean
      (not (holding ?tool))          ; Robot is no longer holding the tool
    )
  )

  (:action mix-ingredient
    :parameters (?r - robot ?ingredient - ingredient ?loc - location)
    :precondition (and 
      (robot-at ?r ?loc)          ; Robot must be at the mixing location
      (holding ?ingredient)       ; Robot must be holding the ingredient
      (mixing-location ?loc))     ; The location must be a mixing location
    :effect (and 
      (ingredient-mixed ?ingredient)  ; Ingredient is now mixed
      (not (holding ?ingredient))      ; Robot is no longer holding the ingredient
    )
  )
)
