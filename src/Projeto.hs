module Projeto where
    import Data
    import Tecnologia
    import Habilidade
    
    data Projeto = Projeto {
        descricao :: String,
        prazo :: Data,
        complexidade :: Int,
        tecnologias :: [Tecnologia],
        requisitos :: [Habilidade],
        nHorasRecomendado :: Int
    }

    getDescricao :: Projeto -> String
    getDescricao = Projeto.descricao

    getPrazo :: Projeto -> String
    getPrazo p = dataToString (prazo p)

    -- retorna complexidade, calculo ainda precisa ser implementado
    getComplexidade :: Projeto -> Int
    getComplexidade = complexidade

    getTecnologias :: Projeto -> [Tecnologia]
    getTecnologias = tecnologias

    getRequisitos :: Projeto -> [Habilidade]
    getRequisitos = requisitos

    getHoras :: Projeto -> Int
    getHoras = nHorasRecomendado

    -- retorna o projeto com a tecnologia que deseja adicionar
    addTecnologia :: Projeto -> Tecnologia -> Projeto
    addTecnologia proj tec = do
        let tecTemp = tecnologias proj ++ [tec]
        proj {tecnologias = tecTemp}

    -- retorna o projeto com a habilidade que deseja adicionar
    addRequisito :: Projeto -> Habilidade -> Projeto
    addRequisito proj hab = do
        let habTemp = requisitos proj ++ [hab]
        proj {requisitos = habTemp}

    -- retorna uma string com todas as tecnologias do projeto
    tecnologiasToString :: [Tecnologia] -> String
    tecnologiasToString [] = ""
    tecnologiasToString listaT = "  " ++ Tecnologia.getNome (head listaT) ++ "\n" ++ tecnologiasToString (tail listaT)

    -- retorna uma string com todas as habilidades do projeto
    requisitosToString :: [Habilidade] -> String
    requisitosToString [] = ""
    requisitosToString listaH = "  " ++ Habilidade.getDescricao (head listaH) ++ "\n" ++ requisitosToString (tail listaH)

    -- retorna uma string com todas as informacoes do projeto
    projetoToString :: Projeto -> String
    projetoToString projeto =
        "Descricao: " ++ Projeto.getDescricao projeto ++ "\n" ++
        "Prazo: " ++ getPrazo projeto ++ "\n" ++
        "Complexidade: " ++ show (getComplexidade projeto) ++ "\n" ++
        "\nTecnologia(s): \n" ++ tecnologiasToString (tecnologias projeto) ++
        "\nRequisito(s): \n" ++ requisitosToString (requisitos projeto) ++
        "\nHoras: " ++ show (getHoras projeto)
