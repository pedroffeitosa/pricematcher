module Desenvolvedor where
    import Especializacao
    import Experiencia
    import Habilidade

    data Desenvolvedor = Desenvolvedor {
        id :: Int,
        nome :: String,
        especializacao :: [Especializacao],
        experiencia :: [Experiencia],
        habilidades :: [Habilidade]
    }

    -- retorna o desenvolvedor com a especializacao que deseja adicionar
    addEspecializacao :: Desenvolvedor -> Especializacao -> Desenvolvedor
    addEspecializacao d e = do
        let espTemp = especializacao d ++ [e]
        d {especializacao = espTemp}

    -- retorna o desenvolvedor com a experiencia que deseja adicionar
    addExperiencia :: Desenvolvedor -> Experiencia -> Desenvolvedor
    addExperiencia d e = do
        let expTemp = experiencia d ++ [e]
        d {experiencia = expTemp}

    -- retorna o desenvolvedor com a habilidade que deseja adicionar
    addHabilidade :: Desenvolvedor -> Habilidade -> Desenvolvedor
    addHabilidade d h = do
        let habTemp = habilidades d ++ [h]
        d {habilidades = habTemp}

    -- retorna uma string com todas as informacoes do desenvolvedor
    desenvolvedorToString :: Desenvolvedor -> String
    desenvolvedorToString desenvolvedor =
        "Nome: " ++ nome desenvolvedor ++ "\n" ++
        "\nEspecializacao(oes): \n" ++ especializacoesToString (especializacao desenvolvedor) ++
        "\nExperiencia(as): \n" ++ experienciasToString (experiencia desenvolvedor) ++
        "\nHabilidade(s): \n" ++ habilidadesToString (habilidades desenvolvedor)

    -- retorna uma string com todas as especializacoes do desenvolvedor
    especializacoesToString :: [Especializacao] -> String
    especializacoesToString [] = ""
    especializacoesToString listaE = "  " ++ Especializacao.getDescricao (head listaE) ++ "\n" ++ especializacoesToString (tail listaE)

    -- retorna uma string com todas as experiencias do desenvolvedor
    experienciasToString :: [Experiencia] -> String
    experienciasToString [] = ""
    experienciasToString listaE = "  " ++ Experiencia.getDescricao (head listaE) ++ "\n" ++ experienciasToString (tail listaE)

    -- retorna uma string com todas as habilidades do desenvolvedor
    habilidadesToString :: [Habilidade] -> String
    habilidadesToString [] = ""
    habilidadesToString listaH = "  " ++ Habilidade.getDescricao (head listaH) ++ "\n" ++ habilidadesToString (tail listaH)
