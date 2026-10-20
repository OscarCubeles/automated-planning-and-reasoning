(define (problem prepare-sushi)
  (:domain robot-cook)
  
  (:objects
    robot-chef - robot
    rice - ingredient
    fish - ingredient
    knife - tool
    sushi - dish  ; Define the dish object
    SA PA CA SVA DWA CTA MIXA - location
  )

  (:init
  
    (not (robot-full))
    (robot-at robot-chef DWA)  ; Robot starts in the storage area
    (ingredient-at rice SA)  ; Rice is in the storage area
    (ingredient-at fish CA)  ; Fish is in the storage area

    (tool-at knife CA)     ; Knife is in the cutting area
    (tool-clean knife)
    
    (adjacent SA CTA)        ; Define adjacency
    (adjacent SA MIXA) 
    (adjacent CTA SA)
    (adjacent CTA MIXA)
    (adjacent MIXA CTA)
    (adjacent MIXA SA)
    (adjacent MIXA PA)
    (adjacent PA DWA)
    (adjacent PA MIXA)
    (adjacent DWA PA)
    (adjacent PA CA)
    (adjacent CA PA)
    (adjacent CA DWA)
    (adjacent CA SVA)
    (adjacent SVA CA)

    ; Define mixing locations
    (mixing-location MIXA)  ; Specify that MIXA is a mixing location
    (cutting-location CA)
    
    ; Define ingredient requirements
    (requires-cutting fish)   ; Fish needs to be cut
    (requires-mixing rice)    ; Rice needs to be mixed

  )

  (:goal (and
    (ingredient-prepared fish)
  ))
)
