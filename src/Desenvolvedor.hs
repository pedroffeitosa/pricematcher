module Desenvolvedor where
import Especializacao
import Experiencia
import Habilidade

data Desenvolvedor = Desenvolvedor {
    id :: Int,
    nome :: String,
    especializacao :: [Especializacao],
    experiencia :: [Experiencia],
    habilidade :: [Habilidade]
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
    let habTemp = habilidade d ++ [h]
    d {habilidade = habTemp}

-- retorna uma string com todas as informacoes do desenvolvedor
toStringDesenvolvedor :: Desenvolvedor -> String
toStringDesenvolvedor desenvolvedor =
    "Nome: " ++ nome desenvolvedor ++ "\n" ++
    "\nEspecializacao(oes): \n" ++ toStringEspecializacoes (especializacao desenvolvedor) ++
    "\nExperiencia(as): \n" ++ toStringExperiencias (experiencia desenvolvedor) ++
    "\nHabilidade(s): \n" ++ toStringHabilidades (habilidade desenvolvedor)

-- retorna uma string com todas as especializacoes do desenvolvedor
toStringEspecializacoes :: [Especializacao] -> String
toStringEspecializacoes [] = ""
toStringEspecializacoes listaE = "  " ++ toStringEspecializacao (head listaE) ++ "\n" ++ toStringEspecializacoes (tail listaE)

-- retorna uma string com todas as experiencias do desenvolvedor
toStringExperiencias :: [Experiencia] -> String
toStringExperiencias [] = ""
toStringExperiencias listaE = "  " ++ toStringExperiencia (head listaE) ++ "\n" ++ toStringExperiencias (tail listaE)

-- retorna uma string com todas as habilidades do desenvolvedor
toStringHabilidades :: [Habilidade] -> String
toStringHabilidades [] = ""
toStringHabilidades listaH = "  " ++ toStringHabilidade (head listaH) ++ "\n" ++ toStringHabilidades (tail listaH)
