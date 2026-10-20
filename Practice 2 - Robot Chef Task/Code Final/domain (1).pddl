(define (domain robot-cook)
  (:requirements :strips :typing :disjunctive-preconditions :negative-preconditions)
  
  (:predicates
    (is-robot ?r)
    (adjacent ?loc1 ?loc2)
    (at ?what ?loc)
    
    (is-knife ?item)
    (is-pot ?item)
    (is-mixer ?item)
    
    (is-fish ?item)
    (is-rice ?item)
    (is-seaweed ?item)

    (is-broth ?item)
    (is-noodles ?item)
    (is-vegetables ?item)
    
    (is-sushi ?dish)
    (is-ramen ?dish)
    
    (cut ?item)
    (cook ?item)
    (mixed ?item)
    
    (mixing-location ?loc)
    (cooking-location ?loc)
    (cutting-location ?loc)  
    (cleaning-location ?loc)
    (preparation-location ?loc)
    (serving-location ?loc)
    
    (clean ?tool)
    
    (have ?r ?item)
    (robot-empty)
    
    (dish-prepared ?dish)
    (dish-served ?dish)

  )

  ;; Mover el robot entre ubicaciones
  (:action move
    :parameters (?r ?loc1 ?loc2)
    :precondition (and 
      (is-robot ?r)
      (at ?r ?loc1) 
      (adjacent ?loc1 ?loc2))
    :effect (and 
      (not (at ?r ?loc1)) 
      (at ?r ?loc2))
  )
  
    ;; Agarrar un ingrediente o herramienta
  (:action pick-up
    :parameters (?r ?item ?loc)
    :precondition (and
      (is-robot ?r)
      (at ?r ?loc)
      (robot-empty)
      (or (is-knife ?item)
        (is-pot ?item)
        (is-mixer ?item)
        (is-fish ?item)
        (is-rice ?item)
        (is-seaweed ?item)
        (is-sushi ?item)
        (is-ramen ?item)
        (is-broth ?item)
        (is-noodles ?item)
        (is-vegetables ?item))
          
      (at ?item ?loc)
    )
    :effect (and
      (have ?r ?item)
      (not (at ?item ?loc))
      (not(robot-empty))
    )
  )
  
  
    ;; Soltar un ingrediente o herramienta
  (:action put-down
    :parameters (?r ?item ?loc)
    :precondition (and
      (is-robot ?r)
      (at ?r ?loc)
      (or (is-knife ?item)
        (is-mixer ?item)
        (is-pot ?item)
        (is-fish ?item)
        (is-rice ?item)
        (is-seaweed ?item)
        (is-sushi ?item)
        (is-ramen ?item)
        (is-broth ?item)
        (is-noodles ?item)
        (is-vegetables ?item))
      (have ?r ?item)
      (not(robot-empty))
    )
    :effect (and
      (at ?item ?loc)
      (not (have ?r ?item))
      (robot-empty)
    )
  )
  
    ;; Cortar ingredientes
  (:action cut
    :parameters (?r ?item ?tool ?loc )
    :precondition (and
      (cutting-location ?loc)
      (is-robot ?r)
      (at ?r ?loc)
      (robot-empty)
      (is-knife ?tool)
      (at ?tool ?loc )
      (clean ?tool)
      (or (is-fish ?item)
          (is-seaweed ?item)
          (is-vegetables ?item))
      (at ?item ?loc)
      (not(cut ?item))
    )
    :effect (and
      (cut ?item)
      (not(clean ?tool))
    )
  )
  
    ;; Mezclar antes de cocinar 
  (:action mix
    :parameters (?r ?item ?loc ?tool)
    :precondition (and
      (mixing-location ?loc)
      (is-mixer ?tool)
      (is-robot ?r)
      (at ?r ?loc)
      (clean ?tool)
      (robot-empty)
      (or(is-rice ?item)
        (is-noodles ?item)
        (is-broth ?item))
      (at ?item ?loc)
    )
    :effect (and
      (mixed ?item)
      (not(clean ?tool))
    )
  )

  ;; Cocinar ingredientes
  (:action cook
    :parameters (?r ?item ?loc ?tool)
    :precondition (and
      (cooking-location ?loc)
      (is-robot ?r)
      (at ?r ?loc)
      (is-pot ?tool)
      (clean ?tool)
      (or(is-rice ?item)
        (is-noodles ?item)
        (is-broth ?item))
      (mixed ?item)
      (at ?item ?loc)
    )
    :effect (and
      (cook ?item)
      (not(clean ?tool))
    )
  )

    ;; Limpiar herramienta
  (:action clean-tool
    :parameters (?r ?tool ?loc)
    :precondition (and
      (cleaning-location ?loc)
      (is-robot ?r)
      (at ?r ?loc)
      (or (is-knife ?tool)
        (is-pot ?tool)
        (is-mixer ?tool)
      )
      (not (clean ?tool))
      (at ?tool ?loc)
    )
    :effect (and 
      (clean ?tool)
    )
  )


  ;; Preparar el plato1 - sushi
  (:action make-sushi
    :parameters (?r ?dish ?loc ?rice ?fish ?seaweed)
    :precondition (and
      (preparation-location ?loc)
      (is-sushi ?dish)
      (is-robot ?r)
      (at ?r ?loc)
      (is-rice ?rice)
      (cook ?rice)
      (at ?rice ?loc)
      (is-fish ?fish)
      (cut ?fish)
      (at ?fish ?loc)
      (is-seaweed ?seaweed)
      (cut ?seaweed)
      (at ?seaweed ?loc)     
      
    )
    :effect (and
      (dish-prepared ?dish)
      (at ?dish ?loc)
    )
  )
  
    ;; Preparar el plato2 - ramen
  (:action make-ramen
    :parameters (?r ?dish ?loc ?broth ?noodles ?vegetables)
    :precondition (and
      (preparation-location ?loc)
      (is-ramen ?dish)
      (is-robot ?r)
      (at ?r ?loc)
      (is-broth ?broth)
      (cook ?broth)
      (at ?broth ?loc)
      (is-noodles ?noodles)
      (cook ?noodles)
      (at ?noodles ?loc)
      (is-vegetables ?vegetables)
      (cut ?vegetables)
      (at ?vegetables ?loc)
    )
    :effect (and
      (dish-prepared ?dish)
      (at ?dish ?loc)
    )
  )

  ;; Servir el plato
  (:action plate-dish
    :parameters (?r ?dish ?loc)
    :precondition (and
      (serving-location ?loc)
      (is-robot ?r)
      (at ?r ?loc)
      (or(is-sushi ?dish)
        (is-ramen ?dish))
      (dish-prepared ?dish)
      (at ?dish ?loc)
    )
    :effect (and
      (dish-served ?dish)
    )
  )
)
