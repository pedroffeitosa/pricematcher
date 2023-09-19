import Especializacao
import Experiencia
import Habilidade
import Desenvolvedor
import Data

main :: IO ()
main = do
    putStrLn "================INICIO================"
    let des = Desenvolvedor 1 "Joao" [] [] [] 10.0
    putStrLn ("-----des1-----: \n" ++ desenvolvedorToString des)
    let esp = Especializacao 1 "esp1" 0.1
    let desTemp = addEspecializacao des esp
    let des = desTemp
    putStrLn ("-----adcEsp1-----: \n" ++ desenvolvedorToString des)
    let desTemp = addEspecializacao des (Especializacao 2 "esp2" 0.1)
    let des = desTemp
    putStrLn ("-----adcEsp2-----: \n" ++ desenvolvedorToString des)
    let desTemp = addExperiencia des (Experiencia 1 "exp1" (Data 10 08 1994) (Data 10 08 1995) 0.1)
    let des = desTemp
    putStrLn ("-----adcXp1-----: \n" ++ desenvolvedorToString des)
    let desTemp = addExperiencia des (Experiencia 2 "exp2" (Data 10 08 1994) (Data 10 08 1995) 0.1)
    let des = desTemp
    putStrLn ("-----adcXp2-----: \n" ++ desenvolvedorToString des)
    let desTemp = addHabilidade des (Habilidade 1 "hab1" 0.1)
    let des = desTemp
    putStrLn ("-----adcHab1-----: \n" ++ desenvolvedorToString des)
    let desTemp = addHabilidade des (Habilidade 2 "Hab2" 0.1)
    let des = desTemp
    putStrLn ("-----adcHab2-----: \n" ++ desenvolvedorToString des)
