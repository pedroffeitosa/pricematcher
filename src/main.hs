import Especializacao
import Experiencia
import Habilidade
import Desenvolvedor

main :: IO ()
main = do
    putStrLn "================INICIO================"
    let des = Desenvolvedor 1 "Joao" [] [] []
    putStrLn ("-----des1-----: \n" ++ desenvolvedorToString des)
    let esp = Especializacao 1 "esp1" 10
    let desTemp = addEspecializacao des esp
    let des = desTemp
    putStrLn ("-----adcEsp1-----: \n" ++ desenvolvedorToString des)
    let desTemp = addEspecializacao des (Especializacao 2 "esp2" 10)
    let des = desTemp
    putStrLn ("-----adcEsp2-----: \n" ++ desenvolvedorToString des)
    let desTemp = addExperiencia des (Experiencia 1 "exp1" 10)
    let des = desTemp
    putStrLn ("-----adcExp1-----: \n" ++ desenvolvedorToString des)
    let desTemp = addExperiencia des (Experiencia 2 "exp2" 10)
    let des = desTemp
    putStrLn ("-----adcExp2-----: \n" ++ desenvolvedorToString des)
    let desTemp = addHabilidade des (Habilidade 1 "hab1" 10)
    let des = desTemp
    putStrLn ("-----adcHab1-----: \n" ++ desenvolvedorToString des)
    let desTemp = addHabilidade des (Habilidade 2 "Hab2" 10)
    let des = desTemp
    putStrLn ("-----adcHab2-----: \n" ++ desenvolvedorToString des)
