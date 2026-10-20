(define (domain robot-cook)
  (:requirements :strips :typing)
  (:types
    robot ingredient tool location dish
  )

  (:predicates
    (robot-at ?r - robot ?loc - location)  
    (ingredient-at ?ingredient - ingredient ?loc - location)  ; Ingredient is at a specific location
    (tool-at ?tool - tool ?loc - location)  ; Tool is at a specific location
    
    (tool-clean ?tool - tool)  ; The tool is clean and ready for use
    
    (holding ?item - (either ingredient tool))  ; Robot is holding an item (ingredient or tool)
    (robot-full)  ; Robot is holding an item (either ingredient or tool)
    
    (adjacent ?loc1 - location ?loc2 - location)  ; Locations are adjacent
    
    (ingredient-mixed ?ingredient - ingredient)  ; Indicates an ingredient has been mixed
    (ingredient-cooked ?ingredient - ingredient)  ; Indicates an ingredient has been cooked
    (ingredient-prepared ?ingredient - ingredient)  ; Indicates an ingredient has been prepared
    
    (mixing-location ?loc - location)  ; Indicates that a location is a mixing area
    (cooking-location ?loc - location)  ; Indicates that a location is a cooking area
    (cutting-location ?loc - location)  ; Indicates that a location is a cutting area
    (cleaning-location ?loc - location)  ; Indicates that a location is a cleaning area
    (preparation-location ?loc - location) ; Indicates that a location is a preparation area
    
    (requires-cutting ?ingredient - ingredient)  ; Ingredient requires cutting
    (requires-mixing ?ingredient - ingredient)  ; Ingredient requires mixing
    (requires-dish ?dish - dish ?ingredient - ingredient)  ; Dish requires an ingredient
    
    (mixing-tool ?tool - tool)  ; Tool is suitable for mixing
    (cutting-tool ?tool - tool)  ; Tool is suitable for cutting
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

  ;; New action: pick-up-tool
  (:action pick-up-tool
    :parameters (?r - robot ?tool - tool ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (tool-at ?tool ?loc)
      (not (robot-full)))  ; Check that the robot is not full
    :effect (and
      (holding ?tool)
      (not (tool-at ?tool ?loc))  ; Remove the tool from its location
      (robot-full))  ; Mark the robot as full
  )

  ;; New action: put-down-tool
  (:action put-down-tool
    :parameters (?r - robot ?tool - tool ?loc - location)
    :precondition (and
      (robot-at ?r ?loc)
      (holding ?tool))  ; Robot must be holding the tool
    :effect (and
      (not (holding ?tool))  ; Robot is no longer holding the tool
      (tool-at ?tool ?loc)  ; The tool is now at the specified location
      (not (robot-full))  ; Robot is no longer full
    )
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
        (and (requires-cutting ?ingredient) (cutting-tool ?tool) (cutting-location ?loc))  ; Ingredient needs cutting
        (and (requires-mixing ?ingredient) (mixing-tool ?tool) (mixing-location ?loc))   ; Ingredient needs mixing
      )
    )
    :effect (and 
      (ingredient-prepared ?ingredient)  ; The ingredient is now prepared
      (not (robot-full))                  ; Robot is now empty
      (not (tool-clean ?tool))            ; Tool is no longer clean
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

  ;; New action: assemble-dish
  (:action assemble-dish
    :parameters (?r - robot ?dish - dish ?loc - location)
    :precondition (and 
      (robot-at ?r ?loc)                    ; Robot must be at the specified location
      (preparation-location ?loc)           ; Ensure that the location is the preparation area
      (forall (?ingredient - ingredient)    ; For all required ingredients
        (and
          (requires-dish ?dish ?ingredient)  ; Check that the dish requires the ingredient
          (ingredient-prepared ?ingredient)   ; Ensure each required ingredient is prepared
          (ingredient-at ?ingredient ?loc)    ; Check that the ingredient is at the location
        )
      )
    )
    :effect (and 
      (dish-prepared ?dish)                 ; The dish is now prepared
      (not (forall (?ingredient - ingredient) 
          (ingredient-prepared ?ingredient))) ; Ingredients are no longer prepared (optional)
    )
  )
)
