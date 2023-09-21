module Projeto where
    import Data
    import Tecnologia
    import Habilidade

    data Projeto = Projeto {
        id :: Int,
        descricao :: String,
        prazo :: Data,
        complexidade :: Complexidade,
        requisitos :: [Habilidade]
    }

    -- Definição de complexidade
    data Complexidade = Facil | Intermediario | Dificil

    -- retorna uma string que informa o valor da complexidade
    complexidadeToString :: Complexidade -> String
    complexidadeToString Facil = "Facil"
    complexidadeToString Intermediario = "Intermediario"
    complexidadeToString Dificil = "Dificil"

    -- retorna a descrição do projeto
    getDescricao :: Projeto -> String
    getDescricao = Projeto.descricao

    -- retorna a data final do projeto em string no formato DD/MM/AAAA
    getPrazo :: Projeto -> String
    getPrazo p = dataToString (prazo p)

    -- retorna a complexidade do projeto
    getComplexidade :: Projeto -> String
    getComplexidade proj = complexidadeToString (complexidade proj)

    -- retorna uma lista de requisitos
    getRequisitos :: Projeto -> [Habilidade]
    getRequisitos = requisitos

    -- retorna o numero de horas recomendado
    getHoras :: Projeto -> Int
    getHoras proj
        | complexidadeToString (complexidade proj) == "Facil" = 80
        | complexidadeToString (complexidade proj) == "Intermediario" = 120
        | otherwise = 180

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
        "Complexidade: " ++ getComplexidade projeto ++ "\n" ++
        "\nRequisito(s): \n" ++ requisitosToString (requisitos projeto) ++
        "\nHoras: " ++ show (getHoras projeto)
