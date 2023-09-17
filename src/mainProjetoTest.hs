import Projeto
import Data
import Tecnologia
import Habilidade

main :: IO()
main = do
    putStrLn "================INICIO================"
    let proj = Projeto "Descricao" (Data 10 08 2024) 0 [] [] 0

    putStrLn (projetoToString proj)

    putStrLn "================Adicionando Tecnologia================"

    let projTemp = addTecnologia proj (Tecnologia "tec1" 1)

    let proj = projTemp

    let projTemp = addTecnologia proj (Tecnologia "tec2" 2)

    let proj = projTemp

    putStrLn (projetoToString proj)

    putStrLn "================Adicionando Habilidade================"

    let projTemp = addRequisito proj (Habilidade 1 "hab1" 1)

    let proj = projTemp

    let projTemp = addRequisito proj (Habilidade 2 "hab2" 3)

    let proj = projTemp

    putStrLn (projetoToString proj)

    putStrLn "================FIM================"