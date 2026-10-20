(define (problem prepare-sushi)
  (:domain robot-cook)
  
  (:objects
    robot-chef - robot
    rice - ingredient
    fish - ingredient
    mixer - tool
    knife - tool
    sushi - dish  ; Define the dish object
    SA PA CA SVA DWA CTA MIXA - location
  )

  (:init
  
    (not (robot-full))
    (robot-at robot-chef CA)  ; Robot starts in the storage area
    (ingredient-at rice SA)  ; Rice is in the storage area
    (ingredient-at fish SA)  ; Fish is in the storage area

    (tool-at mixer DWA)     ; Knife is in the cutting area
    (tool-clean mixer)
    (tool-at knife CTA)
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
    (cleaning-location DWA)
    (preparation-location PA)
    
    ; Define ingredient requirements
    (requires-cutting fish)   ; Fish needs to be cut
    (requires-mixing rice)    ; Rice needs to be mixed
    
    
    (mixing-tool mixer)
    (cutting-tool knife)

  )

  (:goal (and
    (ingredient-prepared rice)
    (ingredient-prepared fish)
  ))
)
