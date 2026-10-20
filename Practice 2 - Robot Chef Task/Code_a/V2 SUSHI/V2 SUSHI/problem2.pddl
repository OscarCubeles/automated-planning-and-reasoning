(define (problem prepare-dish2)
  (:domain robot-cook)

  ;; Define los objetos en el problema
  (:objects
    robot-chef 
    the-rice the-fish the-seaweed the-broth the-noodles the-vegetables
    the-knife
    SA PA CA SVA DWA CTA MIXA
    sushi ramen
  )

  ;; Estado inicial del mundo
  (:init
    ;; Ubicaciones de trabajo
    (cutting-location CTA)
    (cooking-location CA)
    (mixing-location MIXA)
    (preparation-location PA)
    (serving-location SVA)
    (cleaning-location DWA)
    
    ;; Adyacencias entre ubicaciones
    (adjacent SA CTA)   (adjacent CTA SA)
    (adjacent SA MIXA)  (adjacent MIXA SA)
    (adjacent CTA MIXA) (adjacent MIXA CTA)
    (adjacent MIXA PA)  (adjacent PA MIXA)
    (adjacent PA DWA)   (adjacent DWA PA)
    (adjacent PA CA)    (adjacent CA PA)
    (adjacent CA DWA)   (adjacent DWA CA)
    (adjacent CA SVA)   (adjacent SVA CA)
    
    ;; Estado inicial del robot
    (is-robot robot-chef)
    (at robot-chef CA)
    (robot-empty)
    
    ;; Ubicación inicial de ingredientes, todos los ingredientes están disponiles
    
    (is-rice the-rice)
    (at the-rice SA)

    (is-fish the-fish)
    (at the-fish SA)
    
    (is-seaweed the-seaweed)
    (at the-seaweed SA)
    
    (is-vegetables the-vegetables)
    (at the-vegetables SA)
    
    (is-noodles the-noodles)
    (at the-noodles SA)
    
    (is-broth the-broth)
    (at the-broth SA)
    

    
    ;; Herramientas
    (is-knife the-knife)
    (at the-knife CTA)
    (clean the-knife)
    
    
    ;;plato 
    
    (is-ramen ramen)
    
  )
 
  ;; Objetivo: el ramen está preparado y servido, y las herramientas están limpias
  (:goal (and
    (dish-served ramen)
    (clean the-knife)
    


  ))
)
