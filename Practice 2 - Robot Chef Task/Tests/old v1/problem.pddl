(define (problem pick-ingredient)
  (:domain robot-cook)
  
  (:objects
    robot-chef - robot
    rice - ingredient
    fish - ingredient
    knife - tool
    SA PA CA SVA DWA CTA MIXA - location
  )

  (:init
    (robot-at robot-chef SA)  ; Robot starts in the storage area
    (ingredient-at rice SA)  ; Rice is in the storage area
    (ingredient-at fish SA)  ; Fish is in the storage area
    (tool-at knife CTA)     ; Knife is in the cutting area

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
    (cooking-location CA)
  )

  (:goal (and
    (ingredient-mixed rice)  ; The goal is to have the robot hold rice
    (ingredient-cooked fish)
  ))
)
