module Desenvolvedor where
    import Especializacao
    import Experiencia
    import Habilidade

    data Desenvolvedor = Desenvolvedor {
        id :: Int,
        nome :: String,
        especializacao :: [Especializacao],
        experiencia :: [Experiencia],
        habilidades :: [Habilidade],
        valorHora :: Float
    }

    getEspMult :: [Especializacao] -> Float
    getEspMult [] = 0
    getEspMult (head:tail) = Especializacao.getMultiplicador head + getEspMult tail

    getXpMult :: [Experiencia] -> Float
    getXpMult [] = 0
    getXpMult (head:tail) = (Experiencia.getMultiplicador head * (fromIntegral (getAnosTrabalho head) :: Float)) + getXpMult tail

    getHabMult :: [Habilidade] -> Float
    getHabMult [] = 0
    getHabMult (head:tail) = Habilidade.getMultiplicador head + getHabMult tail

    getMultiplicador :: Desenvolvedor -> Float
    getMultiplicador des = getEspMult (especializacao des) + getXpMult (experiencia des) + getHabMult (habilidades des)

    getValorHora :: Desenvolvedor -> Float
    getValorHora des = valorHora des * (1 + Desenvolvedor.getMultiplicador des)

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
        "\nHabilidade(s): \n" ++ habilidadesToString (habilidades desenvolvedor) ++
        "\n Hora: R$ " ++ show (getValorHora desenvolvedor)

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
