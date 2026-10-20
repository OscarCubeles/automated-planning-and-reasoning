(define (domain robot-cook)
  (:requirements :strips :typing)
  (:types
    robot ingredient tool location dish
  )

  (:predicates
    
    (robot-at ?r - robot ?loc - location)  
    (ingredient-at ?ingredient - ingredient ?loc - location)  ; Ingredient is at a specific location
    (tool-at ?tool - tool ?loc - location)  ; Tool is at a specific location
    
    (dish-prepared ?dish - dish)  ; The dish is fully prepared
    (tool-clean ?tool - tool)  ; The tool is clean and ready for use
    (holding ?item - (either ingredient tool))  ; Robot is holding an item (ingredient or tool)
    (robot-full)  ; Robot is holding an item (either ingredient or tool)
    (adjacent ?loc1 - location ?loc2 - location)  ; Locations are adjacent
    (ingredient-mixed ?ingredient - ingredient)  ; Indicates an ingredient has been mixed
    (ingredient-cooked ?ingredient - ingredient)  ; Indicates an ingredient has been cooked
    (ingredient-prepared ?ingredient - ingredient)  ; Indicates an ingredient has been prepared
    (mixing-location ?loc - location)  ; Indicates that a location is a mixing area
    (cooking-location ?loc - location)  ; Indicates that a location is a cooking area
    (cutting-location ?loc - location)  ; Indicates that a location is a cooking area
    (cleaning-location ?loc - location)  ; Indicates that a location is a cleaning area
    (requires-cutting ?ingredient - ingredient)  ; Ingredient requires cutting
    (requires-mixing ?ingredient - ingredient)  ; Ingredient requires mixing
    (requires-dish ?dish - dish ?ingredient - ingredient)  ; Dish requires an ingredient
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

  (:action put-down-ingredient
  :parameters (?r - robot ?ingredient - ingredient ?loc - location)
  :precondition (and
    (robot-at ?r ?loc)         ; Robot must be at the specified location
    (holding ?ingredient)      ; Robot must be holding the ingredient
  )
  :effect (and
    (not (holding ?ingredient)) ; Robot is no longer holding the ingredient
    (ingredient-at ?ingredient ?loc) ; The ingredient is now at the current location
    (not (robot-full))          ; Robot is no longer full
    )
  )
 

  (:action pick-up-ingredient
    :parameters (?r - robot ?ingredient - ingredient ?loc - location)
    :precondition (and 
      (robot-at ?r ?loc) 
      (ingredient-at ?ingredient ?loc) 
      (not (robot-full)))  ; Check that the robot is not full
    :effect (and 
      (holding ?ingredient) 
      (not (ingredient-at ?ingredient ?loc))  ; Remove the ingredient from its location
      (robot-full)  ; Mark the robot as full
    )  ; Robot picks up the ingredient
  )

  ;; Modified generic prepare-ingredient action
  (:action prepare-ingredient
    :parameters (?r - robot ?ingredient - ingredient ?loc - location ?tool - tool)
    :precondition (and 
      (robot-at ?r ?loc)          ; Robot must be at the specified location
      (ingredient-at ?ingredient ?loc)
      (tool-at ?tool ?loc) 
      (tool-clean ?tool)
      (or 
        (and (requires-cutting ?ingredient) (cutting-location ?loc) )  ; Ingredient needs cutting
        (and (requires-mixing ?ingredient) (mixing-location ?loc))   ; Ingredient needs mixing
      )
    )
    :effect (and 
      (ingredient-prepared ?ingredient)  ; The ingredient is now prepared
      (not (robot-full))                  ; Robot is now empty
      (not (tool-clean ?tool))
    )
  )

  (:action cook-ingredient
    :parameters (?r - robot ?ingredient - ingredient ?loc - location)
    :precondition (and 
      (robot-at ?r ?loc)             ; Robot must be in the specified location
      (holding ?ingredient)           ; Robot must be holding the ingredient
      (cooking-location ?loc))        ; Check that the location is a cooking area
    :effect (and
        (not (holding ?ingredient))    ; Robot is no longer holding the ingredient
        (ingredient-cooked ?ingredient) ; The ingredient is now cooked
        (not (robot-full))              ; Robot is now empty
    )  
  )

  (:action clean-tool
    :parameters (?r - robot ?tool - tool ?loc - location)
    :precondition (and 
      (robot-at ?r ?loc)             ; Robot must be in the specified location
      (holding ?tool)                ; Robot must be holding the tool
      (cleaning-location ?loc))      ; Check that the location is a cleaning area
    :effect (and 
      (tool-clean ?tool)             ; Tool is now clean
      (not (holding ?tool))          ; Robot is no longer holding the tool
      (not (robot-full))              ; Robot is now empty
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
      (not (robot-full))               ; Robot is now empty
    )
  )

 
)
